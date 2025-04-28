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
  compose_url   = "https://gituhb.com/larsgjobloop/fullstack-gitops-lite/manifest/compose.yaml"

  network_id = hcloud_network.private_network.id
  network_ip = "10.0.1.1"

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

  network_id = hcloud_network.private_network.id
  network_ip = "10.0.1.2"
}
