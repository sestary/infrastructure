charts_version = {
  argocd      = "7.7.16"
  argocd-apps = "2.0.2"
}

plugins_version = {
  argo-vault-plugin = "1.18.1"
  helm              = "3.16.2"
  jq                = "1.7.1"
  kustomize         = "5.5.0"
  yq                = "4.44.6"
}

enable_ingress = true
enable_oidc    = true

log_level_services = {
  "dex" = "debug"
}
