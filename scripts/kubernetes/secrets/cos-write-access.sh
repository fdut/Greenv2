kubectl create secret generic cos-write-access --type=ibm/ibmc-s3fs --from-literal=access-key=xxxx --from-literal=secret-key=xxxx -n default
