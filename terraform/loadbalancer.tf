resource "digitalocean_loadbalancer" "k3s" {
  name   = "k3s-agents"
  region = "nyc3"

  redirect_http_to_https           = true
  enable_backend_keepalive         = true
  disable_lets_encrypt_dns_records = true

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 30080
    target_protocol = "http"
  }

  forwarding_rule {
    certificate_name = data.digitalocean_certificate.k3s.name

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