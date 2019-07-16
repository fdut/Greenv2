# Drupal on Cloud Object Storage

## IBM Cloud Documentation reference
You need to setup 


https://cloud.ibm.com/docs/containers?topic=containers-object_storage




### Step 1. Get your Certificate CRN
Go back to your certificate Manager service and copy your Certificate CRN

![](img/TLS-deploy1.png)


### Step 2. Deploy your certificate to your IKS Cluster

1. Connect to your IBM Cloud Account by issuing the following command and follow the instructions :
`ibmcloud login -a cloud.ibm.com -r <region> -sso`
 where <region> is eu-gb for London or eu-de for Francfort, ...
2. Download the kubeconfig files for your cluster.
Issue the following command :
`ibmcloud ks cluster-config --cluster Greenv2`
where Greenv2 here is the name of your IKS cluster.
3. You should have this message :
`The configuration for Greenv2 was downloaded successfully.`
`Export environment variables to start using Kubernetes.`
`export KUBECONFIG=/Users/vann/.bluemix/plugins/container-service/clusters/Greenv2/kube-config-lon02-Greenv2.yml`

4. Apply the last line `export KUBECONFIG=...` to make your IKS cluster your default context.
5. Then you are set to deploy your TLS certificate to your IKS Cluster, Issue the following to deploy :
`ibmcloud ks alb-cert-deploy --cluster Greenv2 --secret-name <tls-secret> --cert-crn <Certificate CRN>`.
Where <Certificate CRN> is the CRN you got from **Step 1.** above.
and **<tls-secret>** is the secret name in namespace **ibm-cert-store** and namespace **default**.
Now, the **<tls-secret>** secret is created in **ibm-cert-store** and **default** namespaces.

### Step 3. How to use your certificate when deploying your application
Most details are described [here](https://cloud.ibm.com/docs/containers?topic=containers-ingress_annotation#https-auth).

### Step 4. How to update to a new certificate
Simply issue the following command to update your secret when a new certificate has been re-issued.
`ibmcloud ks alb-cert-deploy --update --cluster Greenv2 --secret-name <tls-secret> --cert-crn <Certificate CRN>`.

