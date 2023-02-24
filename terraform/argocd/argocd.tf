resource "helm_release" "argocd" {
  name        = "argocd"
  namespace   = "argocd"
  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_helm_version

  set {
    name  = "crds.install"
    value = "false"
  }

  depends_on = [
    kubernetes_manifest.argocd_crds
  ]
}

data "kubernetes_secret_v1" "argocd_initial_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }

  depends_on = [
    helm_release.argocd
  ]
}
