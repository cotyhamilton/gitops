# gitops

⚠️ wip

Example of using packer, ansible, and terraform together to build a highly available k3s cluster on digitalocean

---
## Optional
Use the helper setenv.sh script to set environment variables for packer and terraform.

Copy the .env.example to .env and fill out the values

```sh
source ./setenv.sh
```

---
## Prerequisites
- DigitalOcean Account with following resources (see `terraform/data.tf`)
    - ssh key
    - domain
    - wildcard ssl cert for domain
        - personal preference to use an external cert and configure the load balancer to terminate ssl connections instead of using cert manager with LE inside the cluster and risk hitting the rate limits, especially while testing and iterating.

---
## Usage
```sh
# build the image with packer, save the image id to use in terraform
packer build packer

# deploy cluster with terraform
cd terraform
terraform apply

# print kubeconfig
terraform output --raw kubeconfig

# or save
terraform output --raw kubeconfig > ~/.kube/config

# verify
kubectl get nodes

# install example apps

cd ../apps

# install a blank nginx webserver
# update example-website.values.yaml with the correct host for ingress
helm install example-website example-website --values example-website.values.yaml

# install a pod info webserver
# udpate k8s-info.values.yaml with the correct host for ingress
helm install k8s-info k8s-info --values k8s-info.values.yaml
```
