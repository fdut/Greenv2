#!/bin/bash
set -x

ROOT_DIR=`pwd`

# localy
#CR_URL=de.icr.io
#REGISTRY_NAMESPACE=greenv2-ns

# mvp
CR_URL=uk.icr.io
REGISTRY_NAMESPACE=greenv2-ns

echo "$REGISTRY_NAMESPACE - $CR_URL - $ROOT_DIR"

# Build the CONFIG-NGINX image (configure Fast CGI)
cd ../docker/config-nginx
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-nginx:latest .

# Build the CONFIG-PHP-CLI image 
cd ../docker/config-php-cli
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-php-cli:latest .

# Build the CONFIG-PHP-FPM image 
cd ../docker/config-php-fpm
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-php-fpm:latest .

# Move back to ROOT_DIR
cd $ROOT_DIR
