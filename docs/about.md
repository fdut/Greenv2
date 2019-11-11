## Team members

* Frédéric Dutheil - frederic_dutheil@fr.ibm.com
* Abdoul Gadiri Diallo - abdoul.gadiri.diallo@be.ibm.com
* Vann Lam - vann.lam@fr.ibm.com

## Useful links

* [Kanban Project](https://www.bluesight.io/squads/18546/board) overview with Bluesight
* [GitHub repository](https://github.com/fdut/Greenv2)

## App Modernization Map

Part  | Technology used
------------- | -------------
Architecture  | Microservices
Delivery  | DevOps Toolchain
Infrastructure  | Kubernetes Cluster (IKS)
Multi-cloud  | Single Cloud Vendor (IBM Cloud)
Open  | Flexible Architecture with Open Components (Drupal, MySQL, Redis ...)
Security  | Protected with Certs (IBM Cloud Sercurity offering)
Networking | Customized Networking (Feature: using netwok policy)

## Lessons Learned

---

### IBM Kubernetes Service (IKS)

* Very simply to create your first kubernetes cluster
* Understand how to use persistent storage on IKS with different offering. 
* How to use Cloud Object Storage (COS) as persistent volume and integration with IKS

### Security

* Capability to create and manage certificates with IBM Cloud offering : IBM Certificat Manager, IBM Cloud Internet Service, IBM Cloud Domain Name Service
* Vulnarability in the docker images. IBM Cloud platform provide the capability to check the vulnerability of an image. Each vulnarability is notified in the image registry dashboard

### Drupal

* Need to understand how Drupal ecosystem works: requirement, customisation and tools to manage it (drush)
* Using compose to create the docker image.

### Continious delivery Toolchain 

* Using toolchain to create a delivery pipeline to create and deploy image 
* Add Github update event to start the delivery pipeline
* Use Slack to be notified for delivery pipeline exection and status.