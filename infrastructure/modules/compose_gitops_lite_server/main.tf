terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "server" {
  name        = "${var.name}-server"
  image       = "debian-12"
  server_type = var.instance_type
  location    = var.location

  ssh_keys = []
  user_data = templatefile("${path.module}/cloud-init.template.tftpl", {
    ssh_public_key = file("${path.module}/id_rsa.pub")
    compose_url    = var.compose_url
  })

  labels = var.labels

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  network {
    network_id = var.network_id
    ip         = var.network_ip
  }
}
