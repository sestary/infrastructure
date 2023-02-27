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
    namespace = kubernetes_namespace_v1.argocd.metadata[0].name
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

resource "kubernetes_secret_v1" "argocd_vault_plugin_age_key" {
  metadata {
    name      = "argocd-vault-plugin-age-key"
    namespace = kubernetes_namespace_v1.argocd.metadata[0].name
  }

  data = {
    # This file exists outside of Terraform and is not managed in the project
    "key.txt" = file("${path.module}/../../../../../Library/Application Support/sops/age/key.txt")
  }
}
