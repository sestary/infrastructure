locals {
  argocd_crds = [
    "application",
    "applicationset",
    "appproject",
  ]
}

data "http" "argocd_crds" {
  for_each = toset(local.argocd_crds)

  url = "https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/crds/${each.key}-crd.yaml"
}

resource "kubernetes_manifest" "argocd_crds" {
  for_each = data.http.argocd_crds
  manifest = yamldecode(each.value.response_body)
}


