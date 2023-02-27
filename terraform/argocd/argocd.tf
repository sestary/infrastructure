resource "helm_release" "argocd" {
  name      = "argocd"
  namespace = kubernetes_namespace_v1.argocd.metadata[0].name

  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = false

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.charts_version["argocd"]

  values = [
    file("${path.module}/files/manifests/argocd/config.yaml"),
    templatefile(
      "${path.module}/files/manifests/argocd/repo-server.yaml.tpl",
      {
        plugin_versions = var.plugins_version
        plugins         = local.argocd_plugins
      }
    ),
    file("${path.module}/files/manifests/argocd/server.yaml"),
  ]

  set {
    name  = "crds.install"
    value = "false"
  }

  depends_on = [
    kubernetes_manifest.argocd_crds,
    kubernetes_config_map_v1.argocd_plugins,
    kubernetes_secret_v1.argocd_vault_plugin_age_key
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
