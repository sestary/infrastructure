resource "authentik_service_connection_kubernetes" "sestary" {
  name  = "sestary"
  local = true
}

resource "authentik_outpost" "sestary" {
  name = "sestary-outpost"

  protocol_providers = [
    authentik_provider_proxy.longhorn.id,
    authentik_provider_proxy.prometheus.id,
    authentik_provider_proxy.prometheus_alerts.id,
  ]

  service_connection = authentik_service_connection_kubernetes.sestary.id
}
