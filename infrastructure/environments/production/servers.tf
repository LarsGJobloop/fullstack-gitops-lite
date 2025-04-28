locals {
  name     = "fullstack-gitops-lite"
  location = "hel1"
  zone     = "eu-central"
}

module "compose_server" {
  source           = "../../modules/compose_gitops_lite_server"
  name             = "fullstack-gitops-lite"
  location         = "hel1"
  instance_type    = "cax11"
  git_repository   = "https://gituhb.com/larsgjobloop/fullstack-gitops-lite"
  git_access_token = var.git_access_token

  network_id = hcloud_network.private_network.id
  network_ip = hcloud_primary_ip.service_ip4

  depends_on = [hcloud_primary_ip.database_ip4]
}

module "postgresql" {
  source        = "../../modules/postgresql"
  name          = "fullstack-gitops-lite"
  location      = "hel1"
  instance_type = "cax11"

  network_id = hcloud_network.private_network.id
  network_ip = hcloud_primary_ip.service_ip4
}
