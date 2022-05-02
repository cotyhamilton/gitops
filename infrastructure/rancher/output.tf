
output "rancher_server_url" {
  value = "https://${var.rancher_sub_domain}.${var.rancher_root_domain}"
}

output "rancher_node_ip" {
  value = digitalocean_droplet.rancher_server.ipv4_address
}
