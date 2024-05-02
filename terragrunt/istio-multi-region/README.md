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
cd /iac-run-dir/iac-devops/terragrunt
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