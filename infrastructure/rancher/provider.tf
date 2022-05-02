terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.19.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.23.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "1.2.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "digitalocean" {
  token = var.do_token
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_config_server_yaml.filename
  }
}
