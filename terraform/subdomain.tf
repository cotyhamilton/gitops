resource "digitalocean_record" "k3s" {
  domain = data.digitalocean_domain.k3s.id
  type   = "A"
  name   = "*.apps"
  ttl    = 60
  value  = digitalocean_loadbalancer.k3s.ip
}
