#!/bin/bash
set -x

ROOT_DIR=`pwd`

REGISTRY_NAMESPACE=greenv2-ns

CR_URL="$1"
if [ -z "$CR_URL" ] 
then
	echo "MVP set for CR URL : \$CR_URL"
    CR_URL=uk.icr.io
else
	echo "Setting up CR_URL at $CR_URL"
    # Set with your CRL_URL
    # Example: de.icr.io
fi

echo "$REGISTRY_NAMESPACE - $CR_URL - $ROOT_DIR"

# Build the CONFIG-NGINX image (configure Fast CGI)
cd ../docker/config-nginx
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-nginx:latest .

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the CONFIG-PHP-CLI image 
cd ../docker/config-php-cli
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-php-cli:latest .

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the CONFIG-PHP-FPM image 
cd ../docker/config-php-fpm
docker build --tag $CR_URL/$REGISTRY_NAMESPACE/config-php-fpm:latest .

# Move back to ROOT_DIR
cd $ROOT_DIR
