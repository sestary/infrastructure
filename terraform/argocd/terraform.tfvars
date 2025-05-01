charts_version = {
  argocd      = "7.7.16"
  argocd-apps = "2.0.2"
}

plugins_image_tag = "jammy"

enable_ingress = true
enable_oidc    = true

log_level_services = {
  "dex" = "debug"
}
