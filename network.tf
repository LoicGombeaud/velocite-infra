resource "ovh_cloud_project_network_private" "kube" {
  service_name = var.project_name
  name         = "kube_network"
  regions      = [var.region]
}

resource "ovh_cloud_project_network_private_subnet" "kube" {
  service_name = var.project_name
  network_id   = ovh_cloud_project_network_private.kube.id
  region       = var.region
  dhcp         = true
  start        = "10.0.0.2"
  end          = "10.0.0.254"
  network      = "10.0.0.0/24"
}
