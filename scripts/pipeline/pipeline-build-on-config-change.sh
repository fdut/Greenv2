#!/bin/bash
set -e

# Inspect all the files in config and extract into env variables
set -o allexport
for file in ../../config/*.txt
do
  source $file
done
set +o allexport

echo "IMAGE = ${IMAGE}"

# registry on cloud.ibm.com
REGISTRY_NAMESPACE=$CLUSTER_REGISTRY_NAMESPACE

# registry url on cloud.ibm.com
REGISTRY_URL=$CLUSTER_REGISTRY_URL

echo "REGISTRY_URL: $REGISTRY_URL"

case "$IMAGE" in
  "nginx")
    VERSION=$NGINX_VERSION
    ;;
  "php-cli")
    VERSION=$PHP_CLI_VERSION
    ;;
  "php-fpm")
    VERSION=$PHP_FPM_VERSION
    ;;
esac

echo "${IMAGE} version = ${VERSION}"

# Build each image and push
ROOT_DIR=`pwd`

UPCASE_IMAGE=${IMAGE^^}


# Build the NGINX image (configure Fast CGI)
cd ../docker/config-$IMAGE
ibmcloud cr build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-${IMAGE}:${VERSION} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-${IMAGE}:latest \
  --build-arg ${UPCASE_IMAGE//-/_}_VERSION=${VERSION} \
  .
# --no-cache \
#docker push registry.ng.bluemix.net/${REGISTRY_NAMESPACE}/config-${IMAGE}:latest

echo "Done with config build"

# Move back to ROOT_DIR
cd $ROOT_DIR
