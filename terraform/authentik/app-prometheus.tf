resource "authentik_provider_proxy" "prometheus" {
  name = "prometheus"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://prometheus.sestary.eu"
}

resource "authentik_application" "prometheus" {
  name  = "Prometheus"
  slug  = "prometheus"
  group = "Systems"

  protocol_provider = authentik_provider_proxy.prometheus.id

  meta_description = "Prometheus is an open-source systems monitoring and alerting toolkit."
  meta_icon        = "/static/dist/media/prometheus.png"
  meta_publisher   = "Prometheus"
}

resource "authentik_group" "prometheus_admins" {
  name = "prometheus-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "prometheus_group_admins" {
  target = authentik_application.prometheus.uuid
  group  = authentik_group.prometheus_admins.id
  order  = 0
}
