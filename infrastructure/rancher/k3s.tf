# Install k3s
resource "ssh_resource" "install_k3s" {
  host = digitalocean_droplet.rancher_server.ipv4_address
  commands = [
    "bash -c 'curl https://get.k3s.io | INSTALL_K3S_EXEC=\"server --node-external-ip ${digitalocean_droplet.rancher_server.ipv4_address} --node-ip ${digitalocean_droplet.rancher_server.ipv4_address}\" INSTALL_K3S_VERSION=${var.rancher_kubernetes_version} sh -'"
  ]
  user        = "root"
  private_key = file(var.pvt_key)
}

# Get kube config
resource "ssh_resource" "retrieve_config" {
  depends_on = [
    ssh_resource.install_k3s
  ]
  host = digitalocean_droplet.rancher_server.ipv4_address
  commands = [
    "sudo sed \"s/127.0.0.1/${digitalocean_droplet.rancher_server.ipv4_address}/g\" /etc/rancher/k3s/k3s.yaml"
  ]
  user        = "root"
  private_key = file(var.pvt_key)
}