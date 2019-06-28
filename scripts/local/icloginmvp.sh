ibmcloud login -a cloud.ibm.com -r eu-gb --sso
ibmcloud ks cluster-config --cluster Greenv2

export KUBECONFIG=/Users/fred/.bluemix/plugins/container-service/clusters/Greenv2/kube-config-lon02-Greenv2.yml
kubectl cluster-info
kubectl get nodes
