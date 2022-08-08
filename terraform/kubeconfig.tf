# Get kube config
resource "ssh_resource" "kubeconfig" {
  host = digitalocean_droplet.server_init.ipv4_address
  commands = [
    "sed \"s/127.0.0.1/${digitalocean_droplet.server_init.ipv4_address}/g\" /etc/rancher/k3s/k3s.yaml"
  ]
  user        = "root"
  private_key = file(var.private_key_path)
}