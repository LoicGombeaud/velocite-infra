terraform {
  required_providers {
    ovh = {
      source = "ovh/ovh"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].host
    client_certificate     = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_certificate)
    client_key             = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_key)
    cluster_ca_certificate = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].cluster_ca_certificate)
  }
}
