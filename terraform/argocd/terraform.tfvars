charts_version = {
  argocd      = "5.51.2"
  argocd-apps = "1.4.1"
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
