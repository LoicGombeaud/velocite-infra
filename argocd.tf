
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
