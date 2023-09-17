terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    ovh = {
      source = "ovh/ovh"
    }
  }
}

########################################################################
# Début de la section à supprimer lors du tout premier terraform apply #
########################################################################
provider "helm" {
  kubernetes {
    host                   = ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].host
    client_certificate     = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_certificate)
    client_key             = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_key)
    cluster_ca_certificate = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].host
  client_certificate     = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_certificate)
  client_key             = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_key)
  cluster_ca_certificate = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].cluster_ca_certificate)
}
######################################################################
# Fin de la section à supprimer lors du tout premier terraform apply #
######################################################################
