terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_volume" "postgresql_data" {
  name     = "${var.name}-volume"
  size     = 20
  location = var.location
  format   = "ext4"

  labels = {
    type = "postgresql-data"
  }

  delete_protection = var.data_delete_protection
}

resource "hcloud_volume_attachment" "postgresql_attach" {
  volume_id = hcloud_volume.postgresql_data.id
  server_id = hcloud_server.server.id
  automount = false
}

resource "hcloud_server" "server" {
  name        = "${var.name}-postgresql"
  image       = "debian-12"
  server_type = var.instance_type
  location    = var.location

  user_data = templatefile("${path.module}/cloud-init.tftpl", {
    ssh_public_key    = file("${path.root}/id_rsa.pub")
    volume_id         = "${hcloud_volume.postgresql_data.id}"
    hostname          = var.hostname
    server_fqdn       = "${var.name}.internal"
    postgres_password = var.postgres_password
    config_address    = "https://raw.githubusercontent.com/LarsGJobloop/fullstack-gitops-lite/refs/heads/main/infrastructure/modules/postgresql/postgresql.conf"
  })

  labels = var.labels

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  network {
    network_id = var.network_id
    alias_ips  = [] # Fixes https://github.com/hetznercloud/terraform-provider-hcloud/issues/650
  }
}
