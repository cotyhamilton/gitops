resource "ssh_resource" "kubeconfig" {
  host = digitalocean_droplet.k3s_server_init.ipv4_address
  commands = [
    "sed \"s/127.0.0.1:6443/${digitalocean_record.k3s_server.fqdn}/g\" /etc/rancher/k3s/k3s.yaml"
  ]
  user        = "root"
  private_key = file(var.private_key_path)
}