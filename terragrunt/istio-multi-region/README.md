# Demo: Install Multi-Primary on different networks

Steps to orchestrate service mesh with [Istio](https://istio.io/) across two different OKE clusters.

![dual-screenshot](images/multicluster-diff-network.png)

## Prerequisites

For OCI cloud provider

-   Generate admin user api keys as per [OCI Docs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#two)
-   Capture the values for
    - user_id
    - tenancy_id
    - fingerprint
    - region
    - private_key
-   Create a customer secret key for storing terraform state in remote bucket as per [OCI Docs](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/s3compatibleapi.htm#usingAPI)
-   Capture the values for
    - s3 access key
    - s3 secret key
    - s3 region
    - s3 comptability api endpoint
-   Create bucket for storing terraform state files
    - capture the name of the bucket

## Create docker image
```
    git clone https://github.com/ddevadat/iac-devops.git
    cd control-center
    docker build -t control-center-iac-devops .

```

## Start the container

```
docker run -d --name <container_name> control-center-iac-devops sh -c 'while true; do echo "Running"; sleep 360000; done'

```

## Login to the container & set the env variables

```
docker exec -it <container_name> /bin/bash

cd /iac-run-dir
modify environment variables in setenv as appropriate

source setenv
./init.sh
cd /iac-run-dir/iac-devops/terragrunt/istio-multi-region
modify environment.yaml file as appropriate

e.g

region_1: "ap-osaka-1"
region_2: "ap-tokyo-1"
ansible_collection_tag: "main"
ansible_collection_url: "git+https://github.com/ddevadat/iac-devops.git#/ansible/istio/iac"
home_region: "us-ashburn-1"
tenancy_id: "ocid1.tenancy.oc1..aaaaaaaa"
compartment_id: "ocid1.compartment.oc1..aaaaaaaa"
ad_count: 1

```

## Build infrastructure

This IaC uses opentofu and terragrunt for managing the project hierarchy. Entire provsioning roughly takes about 1 hr.

```
docker exec -it <container_name> /bin/bash
cd /iac-run-dir
source setenv
cd /iac-run-dir/iac-devops/terragrunt/istio-multi-region
./run.sh

```


## Verifying Cross-Cluster Traffic

To verify that cross-cluster load balancing works as expected, call the HelloWorld service several times using the Sleep pod. To ensure load balancing is working properly, call the HelloWorld service from all clusters in your deployment.

Send one request from the Sleep pod on cluster1 to the HelloWorld service:

```

export KUBECONFIG=/root/.kube/config
kubectl exec --context="${CTX_CLUSTER1}" -n sample -c sleep \
    "$(kubectl get pod --context="${CTX_CLUSTER1}" -n sample -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- curl -sS helloworld.sample:5000/hello

```
Repeat this request several times and verify that the HelloWorld version should toggle between v1 and v2:

```
Hello version: v2, instance: helloworld-v2-758dd55874-6x4t8
Hello version: v1, instance: helloworld-v1-86f77cd7bd-cpxhv
...

```

Now repeat this process from the Sleep pod on cluster2

```
kubectl exec --context="${CTX_CLUSTER2}" -n sample -c sleep \
    "$(kubectl get pod --context="${CTX_CLUSTER2}" -n sample -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- curl -sS helloworld.sample:5000/hello

```

Repeat this request several times and verify that the HelloWorld version should toggle between v1 and v2:

```
Hello version: v2, instance: helloworld-v2-758dd55874-6x4t8
Hello version: v1, instance: helloworld-v1-86f77cd7bd-cpxhv
...

```

## Cleanup infrastructure

Before running cleanup make sure you are disconnected from wireguard vpn

```
docker exec -it <container_name> /bin/bash
cd /iac-run-dir
source setenv
cd /iac-run-dir/iac-devops/terragrunt/istio-multi-region
./deleteAll.sh

```