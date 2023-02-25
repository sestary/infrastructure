resource "kubernetes_config_map_v1" "argocd_helm_plugin" {
  metadata {
    name      = "helm-plugin-config"
    namespace = "argocd"
  }

  data = {
    "plugin.yaml"       = file("${path.module}/files/plugins/helm/plugin.yaml")
    "generate.sh"       = file("${path.module}/files/plugins/helm/generate.sh")
    "get-parameters.sh" = file("${path.module}/files/plugins/get-parameters.sh")
  }
}

resource "kubernetes_config_map_v1" "argocd_helm_kustomize_plugin" {
  metadata {
    name      = "helm-kustomize-plugin-config"
    namespace = "argocd"
  }

  data = {
    "plugin.yaml"       = file("${path.module}/files/plugins/helm-kustomize/plugin.yaml")
    "generate.sh"       = file("${path.module}/files/plugins/helm-kustomize/generate.sh")
    "get-parameters.sh" = file("${path.module}/files/plugins/get-parameters.sh")
  }
}

resource "helm_release" "argocd" {
  name        = "argocd"
  namespace   = "argocd"
  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_helm_version

  values = [
    file("${path.module}/files/manifests/argocd/repo-server.yaml"),
  ]

  set {
    name  = "crds.install"
    value = "false"
  }

  depends_on = [
    kubernetes_manifest.argocd_crds,
    kubernetes_config_map_v1.argocd_helm_plugin,
    kubernetes_config_map_v1.argocd_helm_kustomize_plugin,
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
