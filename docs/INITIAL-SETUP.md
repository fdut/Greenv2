## Provision a Kubernetes cluster on the IBM Cloud Container Service
- Create a paid IBM Cloud account, and log into the dashboard.
- Choose Containers from the left hand hamburger navigation.

    ![](img/1-hamburger.png)

- Click the Create cluster button.

    ![](img/2-create-cluster.png)

- Select the Standard pay-as-you-go type of cluster (this allows for storage volumes and public floating IPs) and Create.

    ![](img/3-standard-cluster.png)

- Going back to the Dashboard from the navigation, you'll see your cluster.

- Click on it to see the cluster Overview.

    ![](img/4-overview.png)

- Click on Worker Nodes to get details on your worker nodes.

    ![](img/5-worker-nodes.png)

- It will take time for the cluster to complete provisioning, so go get some coffee.

## Connect to your Kubernetes cluster from your workstation
- Click on the Access link to download and configure the `bx` and `kubectl` CLIs. `kubectl` version >=1.7.6 is required.

    ![](img/6-access.png)

- Run the configuration commands, making sure that the `$KUBECONFIG` variable path is indeed correct (it may not reflect your actual home directory).
- You can then use `kubectl` or the `kubectl proxy` dashboard web UI that starts on localhost to inspect your Kubernetes environment.

## Provision and bind two MySQL-as-a-Service instances
- You can do this with the `bx` command too, but I prefer to work with the dashboard as it's just a one time setup operation with several options to browse through.
- Go to the hamburger navigation again and choose Data & Analytics.

    ![](img/7-hamburger-data-analytics.png)

- Click "Create"

    ![](img/8-create-data-analytics.png)

- You have a choice of two MySQL-as-a-Service providers, Compose and ClearDB. ClearDB is quicker to get running with for a PoC. You can use the free plan, but if you need better performance, choose a paid plan.

    ![](img/9-create-mysql-service.png)

- Take note of the credentials, and save them in a `scripts/kubernetes/secrets/service-credentials.txt` file you copy from [`scripts/kubernetes/secrets/service-credentials.txt.tpl`](../scripts/kubernetes/secrets/service-credentials.txt.tpl). There are variables for both a "Staging" database instance and a "Production" instance. They will be separate databases with separate credentials.

For ClearDB, the credentials can be found in the ClearDB Dashboard. Select your database and click the "System Information" tab
    ![](img/13-cleardb-credentials.png)

For Compose, the credentials will be shown right before you create the service.
    ![](img/12-compose-credentials.png)


- The IBM Cloud Container Service offers a way to autobind credentials, but using a secret from this credentials file gives us the option to use services in another organization and space and/or start it up later as its own pod.

- Repeat these steps to create a second database and make sure you have entries for both in the `scripts/kubernetes/secrets/service-credentials.txt` file.

## Provision and bind a Redis-as-a-Service
- You can do this with the `bx` command too, but I prefer to work with the dashboard as it's a one time setup operation with several options.
- Go to the hamburger navigation again and choose Data & Analytics.

    ![](img/7-hamburger-data-analytics.png)

- Click "Create"

    ![](img/8-create-data-analytics.png)

- You have a choice of two Redis-as-a-Service providers, Compose and Redis Cloud. Redis Cloud has a free tier, so you can just use that. 

    ![](img/10-create-redis-service.png)

- Take note of the credentials, and save them in `scripts/kubernetes/secrets/service-credentials.txt`.


- For Compose, the credentials can be found by selecting the service from the dasboard, and clicking "Service Credentials"

    ![](img/14-redis-credentials.png)

## Provision and bind a Memcached-as-a-Service
- You can do this with the `bx` command too, but I prefer to work with the dashboard as it's a one time setup operation with several options.
- Go to the hamburger navigation again and choose Data & Analytics.

    ![](img/7-hamburger-data-analytics.png)

- Click "Create"

    ![](img/8-create-data-analytics.png)

- Choose Memcached from Redis Cloud.

    ![](img/11-create-memcached-service.png)

- Take note of the credentials, and save them in `scripts/kubernetes/secrets/service-credentials.txt`.
