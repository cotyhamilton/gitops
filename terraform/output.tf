output "server_ips" {
  value = flatten([digitalocean_droplet.server_init.ipv4_address, digitalocean_droplet.server.*.ipv4_address])
}

output "agent_ips" {
  value = digitalocean_droplet.agent.*.ipv4_address
}

output "kubeconfig" {
  value     = ssh_resource.kubeconfig.result
  sensitive = true
}