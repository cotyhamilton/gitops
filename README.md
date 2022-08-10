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

# install ingress-nginx first
cd ../apps
helm install ingress-nginx ingress-nginx --values ingress-nginx.values.yaml

# install a blank nginx webserver
# update example-website.values.yaml with the correct host for ingress
helm install example-website example-website --values example-website.values.yaml

# install a pod info webserver
# udpate k8s-info.values.yaml with the correct host for ingress
helm install k8s-info k8s-info --values k8s-info.values.yaml
```
