terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "2.1.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}