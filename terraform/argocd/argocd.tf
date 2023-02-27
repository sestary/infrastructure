locals {
  argocd_plugins = {
    "helm-vault" = {
      files = [
        "generate.sh",
        "get-parameters.sh",
        "init.sh",
      ]
    }
    "kustomize-vault" = {
      files = []
    }
    "vault" = {
      files = []
    }
  }
}

resource "kubernetes_config_map_v1" "argocd_plugins" {
  for_each = local.argocd_plugins

  metadata {
    name      = "argocd-plugin-${each.key}"
    namespace = "argocd"
  }

  data = merge(
    {
      "plugin.yaml" = file("${path.module}/files/plugins/${each.key}/plugin.yaml")
    },
    {
      for file in each.value.files : file => file("${path.module}/files/plugins/${each.key}/${file}")
    }
  )
}

resource "helm_release" "argocd" {
  name        = "argocd"
  namespace   = "argocd"
  description = "Declarative GitOps CD for Kubernetes"

  create_namespace = true

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
  ]

  set {
    name  = "crds.install"
    value = "false"
  }

  depends_on = [
    kubernetes_manifest.argocd_crds,
    kubernetes_config_map_v1.argocd_plugins,
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
