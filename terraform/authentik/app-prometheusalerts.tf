resource "authentik_provider_proxy" "prometheus_alerts" {
  name = "prometheus-alerts"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  external_host = "http://prometheusalerts.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "prometheus_alerts" {
  name  = "Prometheus Alerts"
  slug  = "prometheusalerts"
  group = "Monitoring"

  protocol_provider = authentik_provider_proxy.prometheus_alerts.id

  meta_description = "Prometheus AlertManager is an open-source systems alerting toolkit."
  meta_icon        = "/static/dist/media/prometheusalerts.png"
  meta_publisher   = "Prometheus"
}

resource "authentik_policy_binding" "prometheus_alerts_group_admins" {
  target = authentik_application.prometheus_alerts.uuid
  group  = authentik_group.prometheus_admins.id
  order  = 0
}
