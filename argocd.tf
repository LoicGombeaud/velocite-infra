provider "helm" {
  kubernetes {
    host                   = ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].host
    client_certificate     = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_certificate)
    client_key             = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].client_key)
    cluster_ca_certificate = base64decode(ovh_cloud_project_kube.velocite.kubeconfig_attributes[0].cluster_ca_certificate)
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.3"
  namespace        = "argocd"
  create_namespace = "true"

  values = [
    "${file("argocd-values.yaml")}"
  ]
}
