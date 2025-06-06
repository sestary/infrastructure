locals {
  outpost_config = {
    log_level                      = "info"
    docker_labels                  = null
    authentik_host                 = "https://sso.sestary.eu/"
    docker_network                 = null
    container_image                = null
    docker_map_ports               = true
    kubernetes_replicas            = 1
    kubernetes_namespace           = "auth-authentik"
    authentik_host_browser         = ""
    object_naming_template         = "ak-outpost-%(name)s"
    authentik_host_insecure        = false
    kubernetes_service_type        = "ClusterIP"
    kubernetes_image_pull_secrets  = []
    kubernetes_ingress_class_name  = null
    kubernetes_disabled_components = []
    kubernetes_ingress_annotations = {}
    kubernetes_ingress_secret_name = ""
  }
}

resource "authentik_service_connection_kubernetes" "sestary" {
  name  = "sestary"
  local = true
}

resource "authentik_outpost" "sestary" {
  name = "sestary-outpost"

  config = jsonencode(local.outpost_config)

  protocol_providers = [
    authentik_provider_proxy.filebrowser.id,
    authentik_provider_proxy.prowlarr.id,
    authentik_provider_proxy.radarr.id,
    authentik_provider_proxy.sonarr.id,
    authentik_provider_proxy.solverr.id,
    authentik_provider_proxy.torrent.id,
    authentik_provider_proxy.prometheus.id,
    authentik_provider_proxy.prometheus_alerts.id,
  ]

  service_connection = authentik_service_connection_kubernetes.sestary.id
}
