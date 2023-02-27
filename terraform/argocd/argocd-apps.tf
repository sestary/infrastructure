resource "helm_release" "argocd_apps" {
  name      = "argocd-apps"
  namespace = kubernetes_namespace_v1.argocd.metadata[0].name

  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = var.charts_version["argocd-apps"]

  values = [
    file("${path.module}/files/manifests/apps/appsets.yaml"),
    file("${path.module}/files/manifests/apps/projects.yaml"),
  ]

  depends_on = [
    kubernetes_manifest.argocd_crds
  ]
}
