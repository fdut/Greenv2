#!/bin/bash
set -x

ROOT_DIR=`pwd`

# fred
#CR_URL=de.icr.io
#REGISTRY_NAMESPACE=greenv2-ns

# mvp
CR_URL=uk.icr.io
REGISTRY_NAMESPACE=greenv2-ns

echo "$REGISTRY_NAMESPACE - $CR_URL - $ROOT_DIR"

# Log into the ibmcloud 
#ibmcloud login -a https://cloud.ibm.com --sso

# Log into the ibmcloud Container Registry
#ibmcloud cr login

# Build the NGINX image (configure Fast CGI)
cd ../docker/nginx
# docker build --tag $CR_URL/$REGISTRY_NAMESPACE/nginx:latest --no-cache .
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/nginx:latest .
docker push $CR_URL/$REGISTRY_NAMESPACE/nginx:latest



# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd ../docker/php-fpm
# docker build --tag $CR_URL/$REGISTRY_NAMESPACE/php-fpm:latest --no-cache .
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/php-fpm:latest .
docker push $CR_URL/$REGISTRY_NAMESPACE/php-fpm:latest

exit

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd ../docker/php-cli
# docker build --tag $CR_URL/$REGISTRY_NAMESPACE/php-cli:latest --no-cache .
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/php-cli:latest .
docker push $CR_URL/$REGISTRY_NAMESPACE/php-cli:latest

# Move back to ROOT_DIR
cd $ROOT_DIR
