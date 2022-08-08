resource "digitalocean_record" "rancher" {
  domain = data.digitalocean_domain.gitops.id
  type   = "A"
  name   = "*.apps"
  ttl    = 60
  value  = digitalocean_loadbalancer.gitops.ip
}

resource "digitalocean_loadbalancer" "gitops" {
  name   = "nyc3-load-balancer-01"
  region = "nyc3"

  redirect_http_to_https   = true
  enable_backend_keepalive = true

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 30080
    target_protocol = "http"
  }

  forwarding_rule {
    certificate_name = data.digitalocean_certificate.gitops.name

    entry_port     = 443
    entry_protocol = "https"

    target_port     = 30080
    target_protocol = "http"
    tls_passthrough = false
  }

  healthcheck {
    port     = 30080
    protocol = "tcp"
  }

  droplet_tag = "k3s_agent"
}