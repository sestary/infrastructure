charts_version = {
  argocd      = "5.26.0"
  argocd-apps = "0.0.9"
}

plugins_version = {
  argo-vault-plugin = "1.13.1"
  helm              = "3.11.1"
  jq                = "1.6"
  kustomize         = "5.0.0"
  yq                = "4.24.5"
}

enable_ingress = true
enable_oidc    = true

log_level_services = {
  "dex" = "debug"
}
