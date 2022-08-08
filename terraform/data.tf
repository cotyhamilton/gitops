data "digitalocean_ssh_key" "gitops" {
  name = var.do_ssh_key_name
}

data "digitalocean_certificate" "gitops" {
  name = var.do_ssl_cert_name
}

data "digitalocean_domain" "gitops" {
  name = var.do_domain_name
}