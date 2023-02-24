resource "helm_release" "argocd_apps" {
  name        = "argocd-apps"
  namespace   = "argocd"
  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "0.0.8"

  values = [
    file("${path.module}/files/manifests/apps/projects.yaml"),
    file("${path.module}/files/manifests/apps/core.yaml"),
  ]

  depends_on = [
    kubernetes_manifest.argocd_crds
  ]
}
