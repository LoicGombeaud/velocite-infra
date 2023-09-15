resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.3"
  namespace        = "argocd"
  create_namespace = "true"

  values = [
    "${file("argocd/argocd-values.yaml")}"
  ]
}

resource "kubernetes_manifest" "root_application" {
  manifest = yamldecode(file("argocd/root-application.yaml"))
}
