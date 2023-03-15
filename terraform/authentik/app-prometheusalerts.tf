resource "authentik_provider_proxy" "prometheus_alerts" {
  name = "prometheus-alerts"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://prometheusalerts.sestary.eu"
}

resource "authentik_application" "prometheus_alerts" {
  name  = "Prometheus Alerts"
  slug  = "prometheusalerts"
  group = "Systems"

  protocol_provider = authentik_provider_proxy.prometheus_alerts.id

  meta_description = "Prometheus is an open-source systems monitoring and alerting toolkit."
  meta_icon        = "/static/dist/media/prometheus.png"
  meta_publisher   = "Prometheus"
}

resource "authentik_policy_binding" "prometheus_alerts_group_admins" {
  target = authentik_application.prometheus_alerts.uuid
  group  = authentik_group.prometheus_admins.id
  order  = 0
}
