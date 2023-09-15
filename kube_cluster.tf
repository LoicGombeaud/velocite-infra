resource "ovh_cloud_project_kube" "velocite" {
  service_name = var.project_name
  name         = "velocite"
  region       = var.region
  version      = "1.27"

  private_network_id = tolist(ovh_cloud_project_network_private.kube.regions_attributes[*].openstackid)[0]
}

resource "ovh_cloud_project_kube_nodepool" "small" {
  service_name  = var.project_name
  kube_id       = ovh_cloud_project_kube.velocite.id
  name          = "small"
  flavor_name   = "d2-4"
  desired_nodes = 1
  min_nodes     = 1
  max_nodes     = 1
}

resource "local_file" "kubeconfig" {
  content  = ovh_cloud_project_kube.velocite.kubeconfig
  filename = "${path.module}/kubeconfig"
}
