resource "digitalocean_droplet" "server_init" {
  image    = var.droplet_image
  name     = "k3s-server-0"
  region   = "nyc3"
  size     = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.gitops.id]

  provisioner "remote-exec" {
    inline = ["echo server is online"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    content     = "K3S_TOKEN='${var.k3s_token}'"
    destination = "/etc/systemd/system/k3s.service.env"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    source      = "files/k3s.server_init.service"
    destination = "/etc/systemd/system/k3s.service"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "service k3s start"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }
}

resource "digitalocean_droplet" "server" {
  count    = 2
  image    = var.droplet_image
  name     = "k3s-server-${count.index + 1}"
  region   = "nyc3"
  size     = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.gitops.id]

  provisioner "remote-exec" {
    inline = ["echo server is online"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    content     = "K3S_TOKEN='${var.k3s_token}'\nK3S_SERVER_IP='${digitalocean_droplet.server_init.ipv4_address}'"
    destination = "/etc/systemd/system/k3s.service.env"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    source      = "files/k3s.server.service"
    destination = "/etc/systemd/system/k3s.service"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "service k3s start"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }
}

resource "digitalocean_droplet" "agent" {
  count    = 2
  image    = var.droplet_image
  name     = "k3s-agent-${count.index}"
  region   = "nyc3"
  size     = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.gitops.id]
  tags     = ["k3s_agent"]

  provisioner "remote-exec" {
    inline = ["echo server is online"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    content     = "K3S_TOKEN='${var.k3s_token}'\nK3S_SERVER_IP='${digitalocean_droplet.server_init.ipv4_address}'"
    destination = "/etc/systemd/system/k3s.service.env"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "file" {
    source      = "files/k3s.agent.service"
    destination = "/etc/systemd/system/k3s.service"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "service k3s start"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
    }
  }
}
