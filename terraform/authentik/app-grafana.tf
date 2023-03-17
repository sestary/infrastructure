resource "authentik_application" "grafana" {
  name  = "Grafana"
  slug  = "grafana"
  group = "Monitoring"

  meta_description = "Grafana is a multi-platform open source analytics and interactive visualization web application."
  meta_icon        = "/static/dist/media/grafana.png"
  meta_launch_url  = "https://grafana.sestary.eu"
  meta_publisher   = "Grafana"
}

resource "authentik_group" "grafana_admins" {
  name = "grafana-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "grafana_group_admins" {
  target = authentik_application.grafana.uuid
  group  = authentik_group.grafana_admins.id
  order  = 0
}
