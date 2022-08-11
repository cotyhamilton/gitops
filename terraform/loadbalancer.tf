resource "digitalocean_loadbalancer" "k3s_server" {
  name   = "k3s-server"
  region = "nyc3"

  redirect_http_to_https           = true
  enable_backend_keepalive         = true
  disable_lets_encrypt_dns_records = true
  vpc_uuid                         = digitalocean_vpc.k3s.id

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 6443
    target_protocol = "https"
    tls_passthrough = true
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_tag = "k3s-server"
}

resource "digitalocean_loadbalancer" "k3s_agent" {
  name   = "k3s-agents"
  region = "nyc3"

  redirect_http_to_https           = true
  enable_backend_keepalive         = true
  disable_lets_encrypt_dns_records = true
  vpc_uuid                         = digitalocean_vpc.k3s.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    certificate_name = data.digitalocean_certificate.k3s.name

    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"
    tls_passthrough = false
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_tag = "k3s-agent"
}