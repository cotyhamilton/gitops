# DO infrastructure resources

# SSH Key
data "digitalocean_ssh_key" "automation" {
  name = "key"
}

# DO droplet for creating a single node cluster and installing the Rancher server
resource "digitalocean_droplet" "rancher_server" {
  name     = "rancher-server"
  image    = var.droplet_image
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.automation.fingerprint]
}

# DO root domain to host rancher, must exist in DO
data "digitalocean_domain" "root" {
  name = var.rancher_root_domain
}

# DO subdomain to host rancher
resource "digitalocean_record" "rancher" {
  domain = data.digitalocean_domain.root.id
  type   = "A"
  name   = var.rancher_sub_domain
  ttl    = 3600
  value  = digitalocean_droplet.rancher_server.ipv4_address
}
