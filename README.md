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
```
