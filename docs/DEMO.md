# Drupal sites on the IBM Container Service

## Preamble: Why Kubernetes?
The shift towards cloud-native deployment models allows developers to package their applications consistently between staging and production, and helps them scale their deployments horizontally across a large pool of compute resources more quickly.

In contrast to other cloud-native approaches - like Platform-as-a-Service with Heroku or Cloud Foundry - container orchestration system like Kubernetes are "less-opinionated" and offer a great amount of flexibility at the cost of a single prescribed set of guidelines, which can make them more attractive to those migrating from a virtual machine or bare metal approach rather than towards PaaS directly.

## What this MVP shows
This MVP shows how one might migrate a traditional web-server, application-server, and database-server based application into a container-based model that depends on cloud services in order to speed application development by reducing time spent on managing servers across a large deployment target environment.

1. [Functional Drupal site running on the IBM Cloud](#1-functional-drupal-site-running-on-the-ibm-cloud)
2. [Clearly defined and easy to implement process for pushing code updates](#2-clearly-defined-and-easy-to-implement-process-for-pushing-code-updates)
3. [Synchronize or migrate one database to another database](#3-synchronize-or-migrate-one-database-to-another-database)
4. [Taking advantage of a continous integration pipeline](#4-taking-advantage-of-a-continous-integration-pipeline)

## 1. Functional Drupal site running on the IBM Cloud
A managed Kubernetes cluster from the IBM Kubernetes Service provides the fabric on which to install a set of NGINX and PHP-FPM containers that run Drupal.

These containers package custom site code and the underlying Kubernetes fabric can bind those containers to data services, load balancers, and storage volumes provided by the IBM Cloud.

### 1.1 Initial environment setup
The [initial setup](INITIAL-SETUP.md) instructions show how to set up a Kubernetes cluster and provision the MySQL, Redis, and Memcached services needed by the Drupal cluster.

### 1.2 First container cluster deployment
Once the fabric and services are configured, you can build container images and deploy them to the IBM Container Service manually or through an automated pipeline. The [container deployment instructions](DEPLOY-CONTAINERS.md) describe how.

### 1.3 Complete Drupal configuration
Connecting to Drupal to finish installation. Once all of the containers have gotten to the `Running` state (you can see status with 'kubectl get pods') you can find the public IP of the Drupal cluster with `kubectl get services`. Because the `settings.php` file has been set up to get the MySQL connection information from the Kubernetes environment, it's a shorter process than normal.

## 2. Clearly defined and easy to implement process for pushing code updates
Once the initial environment is set up, you can initiate additional build, test, and deploy workflows by committing code to specific folders in this repository. This simulates GitHub or BitBucket web hooks.

### 2.1 Updating the underlying NGINX and PHP container images
You can commit updated NGINX or PHP version files to the `config` directory. This will in turn trigger base image rebuilds in the DevOps pipeline, and in turn rebuild custom Drupal-based `code` images on top and deploy them.

### 2.2 Updating custom code and triggering code layer rebuilds
You can commit code that should be layered on top of base NGINX, PHP, and Drupal installation by changing code in the `code` directory. This will trigger a custom code rebuild and deploy.

## 3. Synchronize or migrate one database to another database
Ongoing management of the Drupal cluster can be performed with arbitrary shell commands and `drush` commands invoked by logging into the PHP-CLI container. This container could also be extended to run arbitrary commands on startup through the DevOps pipeline.

### 3.1. Using the PHP CLI container to execute arbitrary commands
You can exec into the PHP CLI container to [run arbitrary bash or MySQL commands](PHP-CLI-DRUSH.md).

### 3.2. Using the PHP CLI container to execute migration commands
You can exec into the PHP CLI container to [run the `transfer-data.sh` and `transfer-files.sh` scripts injected from the `code/drush` directory](PHP-CLI-DRUSH.md). For example: `kubectl exec ${PHP_CLI_CONTAINER_NAME} /root/drush/transfer-files.sh` and `kubectl exec ${PHP_CLI_CONTAINER_NAME} /root/drush/transfer-data.sh`

### 3.3. Using a PHP FPM container to execute `drush` commands
You can exec into the PHP FPM container to [run the `drush-status.sh` script injected from the `code/drush` directory](PHP-CLI-DRUSH.md). For example: `kubectl exec ${PHP_FPM_CONTAINER_NAME} /var/www/drupal/drush/drush-status.sh`

## 4. Taking advantage of a continuous integration pipeline
The [pipeline setup instructions](PIPELINE-SETUP.md) show how IBM DevOps can be used with user-defined scripts and webhooks to initiate build, test, and deployment flows. These can incorporate unit test scripts, security vulnerability assessments, and blue/green rolling deploys. These workflows can reuse build tool Docker images as well, which is a new feature of IBM DevOps services.

### 4.1. Checking in configuration or code updates
Once configured, the pipeline will detect changes to the top level `config` and `code` directories and trigger new build and deploy processes depending on the change.

### 4.2 Synchronizing data from production to staging
You can also use the pipeline UI to execute data and file synchronization. You can also set up arbitrary script execution by extending this model.
