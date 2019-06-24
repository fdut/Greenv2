#!/bin/bash
set -x

# Processes everything in the kubernetes folder:
# - Create the shared persistent volume
# - Create the deployment replication controllers for NGINX and PHP-FPM
# - Create the services for the NGINX and PHP-FPM deployment
kubectl create -f .

# Confirm everything looks good

