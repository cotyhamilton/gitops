packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}

variable "do_token" {
  type        = string
  description = "DigitalOcean API token used to create infrastructure"
  sensitive   = true
}

source "digitalocean" "gitops" {
  api_token     = var.do_token
  image         = "ubuntu-22-04-x64"
  region        = "nyc3"
  size          = "s-1vcpu-1gb"
  ssh_username  = "root"
  snapshot_name = "k3s-${timestamp()}"
}

build {
  sources = [
    "source.digitalocean.gitops"
  ]

  provisioner "ansible" {
    playbook_file   = "../ansible/site.yml"
    extra_arguments = ["-v"]
  }
}