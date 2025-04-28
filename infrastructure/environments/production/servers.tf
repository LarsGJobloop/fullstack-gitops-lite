locals {
  name                 = "fullstack-gitops-lite"
  location             = "hel1"
  zone                 = "eu-central"
  service_server_lable = "role=services"
}

module "compose_server" {
  source        = "../../modules/compose_gitops_lite_server"
  name          = "fullstack-gitops-lite"
  location      = "hel1"
  instance_type = "cax11"
  hostname      = "services"

  compose_url      = "https://raw.githubusercontent.com/LarsGJobloop/fullstack-gitops-lite/refs/heads/main/manifests/compose.yaml"
  refresh_interval = "*/30 * * * *"

  network_id = hcloud_network.private_network.id

  labels = {
    role = "services"
  }

  depends_on = [hcloud_network_subnet.subnet]
}

module "postgresql" {
  source        = "../../modules/postgresql"
  name          = "fullstack-gitops-lite"
  location      = "hel1"
  instance_type = "cax11"
  hostname      = "postgresql"

  labels = {
    role = "storage"
  }

  network_id = hcloud_network.private_network.id

  depends_on = [hcloud_network_subnet.subnet]
}
