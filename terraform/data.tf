data "digitalocean_ssh_key" "k3s" {
  name = var.do_ssh_key_name
}

data "digitalocean_certificate" "k3s" {
  name = var.do_ssl_cert_name
}

data "digitalocean_domain" "k3s" {
  name = var.do_domain_name
}