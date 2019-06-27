# This Dockerfile builds on the base image and adds static code

ARG NGINX_VERSION=latest
ARG REGISTRY_NAMESPACE=greenv2-ns
ARG CR_URL=uk.icr.io

FROM ${CR_URL}/${REGISTRY_NAMESPACE}/config-nginx:${NGINX_VERSION}

LABEL Description="FDUT: Base nginx image for MVP" Vendor="Greenv2" Version="1.0"

RUN echo "Using this Registry url:  $CR_URL"

# Allow Composer to be run as root.
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install prerequisite OS packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php7.0-cli php7.0-xml php7.0-gd php7.0-intl php7.0-xsl php7.0-curl php7.0-mbstring zip git

# --- We do this to add static files, but we should look at an alternative approach.

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

COPY tmp/composer.json ./

# COPY tmp/composer.lock ./

RUN composer install --no-scripts --no-autoloader

COPY . ./

RUN composer create-project drupal-composer/drupal-project:8.x-dev /var/www/drupal/ --no-interaction

ADD tmp/modules/ /var/www/drupal/web/modules/
ADD tmp/profiles/ /var/www/drupal/web/profiles/
ADD tmp/sites/ /var/www/drupal/web/sites/
ADD tmp/themes/ /var/www/drupal/web/themes/
ADD tmp/config/ /var/www/drupal/config/

# --- We do the above to add static files, but we should look at an alternative approach.

WORKDIR /var/www/drupal/web

COPY start.sh /root/
RUN chmod +x /root/start.sh

EXPOSE 80

ENTRYPOINT ["/root/start.sh"]
