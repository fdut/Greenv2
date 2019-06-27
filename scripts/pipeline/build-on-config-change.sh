#!/bin/bash
set -e

# Inspect all the files in config and extract into env variables
set -o allexport
for file in ../../config/*.txt
do
  source $file
done
set +o allexport

echo $NGINX_VERSION
echo $PHP_FPM_VERSION
echo $PHP_CLI_VERSION
echo $CLUSTER_REGISTRY_NAMESPACE
echo $CLUSTER_REGISTRY_URL

# Build each image and push
ROOT_DIR=`pwd`

# registry on cloud.ibm.com
REGISTRY_NAMESPACE=$CLUSTER_REGISTRY_NAMESPACE

# registry url on cloud.ibm.com
REGISTRY_URL=$CLUSTER_REGISTRY_URL

echo "CR_CRL: $REGISTRY_URL"

# Log into the IBM Cloud Container Registry
#ibmcloud cr login

# Purge all existing images
#ibmcloud cr image-rm $(ibmcloud cr images -q)

# Build the NGINX image (configure Fast CGI)
cd ../docker/config-nginx
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-nginx:${NGINX_VERSION} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-nginx:latest \
  --build-arg NGINX_VERSION=${NGINX_VERSION} \
  --build-arg CR_URL=${REGISTRY_URL} \
  .
# --no-cache \
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/config-nginx:latest

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd ../docker/config-php-fpm
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-fpm:${PHP_FPM_VERSION} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-fpm:latest \
  --build-arg PHP_FPM_VERSION=${PHP_FPM_VERSION} \
  --build-arg CR_URL=${REGISTRY_URL} \
  .
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-fpm:latest

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd ../docker/config-php-cli
docker build \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-cli:${PHP_CLI_VERSION} \
  --tag $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-cli:latest \
  --build-arg PHP_CLI_VERSION=${PHP_CLI_VERSION} \
  --build-arg CR_URL=${REGISTRY_URL} \
  .
docker push $REGISTRY_URL/$REGISTRY_NAMESPACE/config-php-cli:latest
# Move back to ROOT_DIR
cd $ROOT_DIR

# TODO: invoke ./build-on-code-change.sh with env params
./build-on-code-change.sh
