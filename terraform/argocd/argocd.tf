locals {
  hostname = "argocd.sestary.eu"
  url      = "https://${local.hostname}"
}

resource "helm_release" "argocd" {
  name      = "argocd"
  namespace = kubernetes_namespace_v1.argocd.metadata[0].name

  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = false

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.charts_version["argocd"]

  values = [
    templatefile(
      "${path.module}/files/manifests/argocd/config.yaml.tftpl",
      {
        enable_oidc = var.enable_oidc
        oidc        = var.enable_oidc ? data.terraform_remote_state.authentik[0].outputs.argocd_oidc : {}
        url         = local.url
      }
    ),
    templatefile(
      "${path.module}/files/manifests/argocd/logging.yaml.tftpl",
      {
        log_level_applicationSet = lookup(var.log_level_services, "applicationSet", var.log_level_default)
        log_level_controller     = lookup(var.log_level_services, "controller", var.log_level_default)
        log_level_dex            = lookup(var.log_level_services, "dex", var.log_level_default)
        log_level_repoServer     = lookup(var.log_level_services, "repo_server", var.log_level_default)
        log_level_server         = lookup(var.log_level_services, "server", var.log_level_default)

      }
    ),
    templatefile(
      "${path.module}/files/manifests/argocd/repo-server.yaml.tftpl",
      {
        plugins_image_tag = var.plugins_image_tag
        plugins           = local.argocd_plugins
      }
    ),
    templatefile(
      "${path.module}/files/manifests/argocd/server.yaml.tftpl",
      {
        enable_ingress = var.enable_ingress
        enable_oidc    = var.enable_oidc
        hostname       = local.hostname
      }
    ),
  ]

  set = [
    {
      name  = "crds.install"
      value = "false"
    }
  ]

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

