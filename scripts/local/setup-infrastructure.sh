#!/bin/bash
set -x

# If needed. Otherwise set up the cluster and the services in the UI.

# Let's get started by installing the needed CLIs, setting up your first private registry namespace, and pushing your first image.

# Install, Set Up, and Log In
# 1. Install the IBM Cloud CLI.

# 2. Install the Docker CLI.

# 3. Install the Container Registry plug-in.

# ibmcloud plugin install container-registry -r Bluemix

# 4. Log in to your IBM Cloud account.

# ibmcloud login -a https://cloud.ibm.com

# If you have a federated ID, use ibmcloud login --sso to log in to the IBM Cloud CLI.

# 5. Choose a name for your first namespace, and create that namespace. Use this namespace for the rest of the Quick Start.

# ibmcloud cr namespace-add <my_namespace>

# Push the image to your private registry
# 1. Log your local Docker daemon into the IBM Cloud Container Registry.

# ibmcloud cr login

# 2. Pull a test image from Docker Hub.

# docker pull hello-world

# 3. Choose a repository and tag by which you can identify the image. Use the same repository and tag for the rest of this Quick Start.

# docker tag hello-world us.icr.io/<my_namespace>/<my_repository>:<my_tag>

# 4. Push the image.

# docker push us.icr.io/<my_namespace>/<my_repository>:<my_tag>

# 5. Verify that your image is in your private registry.

# ibmcloud cr image-list



# 3. Provision MySQL from Compose or ClearDB
# 3.1. TODO:

# 4. Provision Redis from Compose or Redis Labs
# 4.1. TODO:

# 5. Provision memcached from Redis Labs
# 5.1. TODO:
