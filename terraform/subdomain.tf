resource "digitalocean_record" "k3s_server" {
  domain = data.digitalocean_domain.k3s.id
  type   = "A"
  name   = "k3s"
  ttl    = 60
  value  = digitalocean_loadbalancer.k3s_server.ip
}

resource "digitalocean_record" "k3s_agent" {
  domain = data.digitalocean_domain.k3s.id
  type   = "A"
  name   = "*.apps"
  ttl    = 60
  value  = digitalocean_loadbalancer.k3s_agent.ip
}
