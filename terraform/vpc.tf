resource "digitalocean_vpc" "k3s" {
  name     = "k3s"
  region   = "nyc3"
  ip_range = "10.29.0.0/20"
}