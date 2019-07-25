
VERSION="$1"
if [ -z "$VERSION" ] 
then
	echo "Do nothing"
else
	echo "Setting up version in config-nginx DokerFile (LABEL)"
    sed -e "s/Version=\".*\"/Version=\"${VERSION}\"/g" ../docker/config-nginx/Dockerfile > ../docker/config-nginx/Dockerfile.tmp
    cp -f ../docker/config-nginx/Dockerfile.tmp ../docker/config-nginx/Dockerfile
    git add ../docker/config-nginx/Dockerfile
	echo "Setting up version in config-php-cli DokerFile (LABEL)"
    sed -e "s/Version=\".*\"/Version=\"${VERSION}\"/g" ../docker/config-php-cli/Dockerfile > ../docker/config-php-cli/Dockerfile.tmp
    cp -f ../docker/config-php-cli/Dockerfile.tmp ../docker/config-php-cli/Dockerfile
    git add ../docker/config-php-cli/Dockerfile
    echo "Setting up version in config-php-fpm DokerFile (LABEL)"
    sed -e "s/Version=\".*\"/Version=\"${VERSION}\"/g" ../docker/config-php-fpm/Dockerfile > ../docker/config-php-fpm/Dockerfile.tmp
    cp -f ../docker/config-php-fpm/Dockerfile.tmp ../docker/config-php-fpm/Dockerfile
    git add ../docker/config-php-fpm/Dockerfile
    git commit -m "Update config image to version ${VERSION}"
    git push
fi
