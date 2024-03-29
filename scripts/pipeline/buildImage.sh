#!/bin/bash

echo -e "Build environment variables:"
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "IMAGE_NAME=${IMAGE_NAME}"

IMAGE=$IMAGE_NAME

# variable to know if we need to redeploy or no the image
# redeploy REDEPLOY="YES" , no change REDEPLOY=""
REDEPLOY="NO"

echo "IMAGE: $IMAGE"

echo "Files changed in previous commit :"
echo `git log -m -1 --name-only` 
echo 'git log -m -1 --name-only | grep "config/.*${IMAGE_NAME}.*"' `git log -m -1 --name-only | grep "config/.*${IMAGE_NAME}.*"`

# Check for mentions of the config and docker directories in the last commit.
## --old check -- if [ `git log -m -1 --name-only | grep "config/"` ] || [ `git log -m -1 --name-only | grep "docker/"` ] ; then
if [ `git log -m -1 --name-only | grep "config/.*${IMAGE_NAME}.*"` ] || [ `git log -m -1 --name-only | grep "docker/co.*-${IMAGE_NAME}"` ] ; then
  echo "-- Changes found in config/ or docker/ directory"
  # Call the build-on-config-change.sh script
  . ./pipeline-build-on-config-change.sh
  . ./pipeline-build-on-code-change.sh
  
  # Set value to redeploy image
  REDEPLOY="YES"

# Check for changes to the /code directory in the last commit.
elif git log -m -1 --name-only | grep "code/" ; then
  echo "-- Changes found in code/ directory"
  # Call the build-on-code-change.sh script
  . ./pipeline-build-on-code-change.sh

  # Set value to redeploy image
  REDEPLOY="YES"
else
  echo "-- No Changes found for image ${IMAGE_NAME}"
fi

echo "-- END of Build"

######################################################################################
# Copy any artifacts that will be needed for deployment and testing to $WORKSPACE    #
######################################################################################
echo "=========================================================="
echo "COPYING ARTIFACTS needed for deployment and testing (in particular build.properties)"

echo "Checking archive dir presence"
if [ -z "${ARCHIVE_DIR}" ]; then
  echo -e "Build archive directory contains entire working directory."
else
  echo -e "Copying working dir into build archive directory: ${ARCHIVE_DIR} "
  mkdir -p ${ARCHIVE_DIR}
  find . -mindepth 1 -maxdepth 1 -not -path "./$ARCHIVE_DIR" -exec cp -R '{}' "${ARCHIVE_DIR}/" ';'
fi

# Persist env variables into a properties file (build.properties) so that all pipeline stages consuming this
# build as input and configured with an environment properties file valued 'build.properties'
# will be able to reuse the env variables in their job shell scripts.

# If already defined build.properties from prior build job, append to it.
cp build.properties ${ARCHIVE_DIR}/ || :

# Pass kubernetes files along with build artifacts
cp -r ../kubernetes/ ${ARCHIVE_DIR}

echo -e "Copying artifacts needed for deployment and testing"
pwd
ls -l
echo -e "ls -l"
ls -l ${ARCHIVE_DIR}

echo -e "Save the registry url and namespace in the build artifacts to be used in deploy stage."
echo "REGISTRY_URL=${REGISTRY_URL}" >> ${ARCHIVE_DIR}/build.properties
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}" >> ${ARCHIVE_DIR}/build.properties
echo "IMAGE=${IMAGE}" >> ${ARCHIVE_DIR}/build.properties

echo "REDEPLOY=${REDEPLOY}" >> ${ARCHIVE_DIR}/build.properties

# IMAGE_NAME from build.properties is used by Vulnerability Advisor job to reference the image qualified location in registry
echo "IMAGE_NAME=${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE}:latest" >> ${ARCHIVE_DIR}/build.properties
echo "File 'build.properties' created for passing env variables to subsequent pipeline jobs:"
cat $ARCHIVE_DIR/build.properties

echo -e "-- END of script --"
