charts_version = {
  argocd      = "6.7.11"
  argocd-apps = "2.0.0"
}

plugins_version = {
  argo-vault-plugin = "1.17.0"
  helm              = "3.13.2"
  jq                = "1.7"
  kustomize         = "5.2.1"
  yq                = "4.40.3"
}

enable_ingress = true
enable_oidc    = true

log_level_services = {
  "dex" = "debug"
}
