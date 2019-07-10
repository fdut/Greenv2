# Greenv2

## Project Context

- Client requires CMS-as-a-Service
- Drupal is the CMS technology of choice
- Many competitors in this space; mostly open source
- With CMS-aaS we must provide a DevOps solution
- Dependencies with Drupal: LAMP stack and Caching
- End goal: To provide the fastest solution to get new content into Production

## Functional requirements

Separate environments for: 
- Dev;
- Test;
- Production;
- Site must be hosted on public cloud;
Site must be accessible globally;
Code deployment can be done using FTP/SFTP;
Content distribution using CDN;
SMTP setup to facilitate email communication to support “Contact Us” function in the website;

## Non-functional requirements

Security:
- Enterprise grade firewalling;
- DDOS protection;
- Availability:
- High Availability of the infrastructure platform;

Scalability:
- Scalable infrastructure with possible future expansion of the website.
- Infrastructure support for services around DNS mapping and Certificate installation.

## Logical architecture

![Logical Architecture](arch/LogicalArchitecture.jpg)


+ [Setup - Setup your environnement](./labs/envSetup.md)
+ [Lab 1 - Exposing a Rest API with API Connect](./labs/lab01.md)
+ [Lab 2 - Publication and Developer Portal](./labs/lab02.md)
+ [Lab 3 - Routing and SOAP Service](./labs/lab03.md)
+ [Lab 4 - Secure a API with OAuth2](./labs/lab04.md)
+ [Lab 5 - Analytics](./labs/lab05.md)

