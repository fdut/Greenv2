#!/bin/bash
set -e

# Inspect all the files in config and extract into env variables
set -o allexport
for file in ../../code/*.txt
do
  source $file
done
for file in ../../config/*.txt
do
  source $file
done
set +o allexport

BUILD_NUMBER=$( date +%s )

echo $DRUPAL_VERSION
echo $DRUPAL_MD5
echo $DRUSH_VERSION
echo $NGINX_VERSION     # Override from args
echo $PHP_FPM_VERSION   # Override from args
echo $PHP_CLI_VERSION   # Override from args
echo $CLUSTER_REGISTRY_NAMESPACE
echo $CLUSTER_REGISTRY_URL

# Build each image and push
ROOT_DIR=`pwd`

# registry on cloud.ibm.com
REGISTRY_NAMESPACE=$CLUSTER_REGISTRY_NAMESPACE

# registry url on cloud.ibm.com
REGISTRY_URL=$CLUSTER_REGISTRY_URL

echo "REGISTRY_URL: $REGISTRY_URL"

# Log into the IBM Cloud Container Registry
#ibmcloud cr login

# Build the NGINX image (configure Fast CGI)
cd ../docker/code-nginx
if [ -d tmp ]; then
  rm -fr tmp
fi
mkdir tmp
cp -R ../../../code/* tmp/
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-nginx:${BUILD_NUMBER} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-nginx:latest \
  --build-arg CR_URL=${REGISTRY_URL} \
  .
# --no-cache \
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/code-nginx:latest
rm -fr tmp

echo ##########  code-php-fpm  ##########

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)

echo "Build the PHP-FPM image (base image, inject code, run composer)"

cd ../docker/code-php-fpm
if [ -d tmp ]; then
  rm -fr tmp
fi
mkdir tmp
cp -R ../../../code/* tmp/
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-fpm:${BUILD_NUMBER} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-fpm:latest \
  --build-arg DRUPAL_MD5=${DRUPAL_MD5} \
  --build-arg DRUPAL_VERSION=${DRUPAL_VERSION} \
  --build-arg CR_URL=${REGISTRY_URL} \
  --no-cache \
  .
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-fpm:latest
rm -fr tmp

echo ##########  code-php-cli  ##########

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-CLI image (base image, inject code, run composer)
cd ../docker/code-php-cli
if [ -d tmp ]; then
  rm -fr tmp
fi
mkdir tmp
cp -R ../../../code/* tmp/
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-cli:${BUILD_NUMBER} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-cli:latest \
  --build-arg DRUSH_VERSION=${DRUSH_VERSION} \
  --build-arg CR_URL=${REGISTRY_URL} \
  .
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/code-php-cli:latest
rm -fr tmp

# Move back to ROOT_DIR
cd $ROOT_DIR
