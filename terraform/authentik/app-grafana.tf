resource "random_password" "client_secret_grafana" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "grafana" {
  name          = "grafana"
  client_id     = "grafana"
  client_secret = random_password.client_secret_grafana.result

  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = "http://grafana.sestary.eu/login/generic_oauth",
    },
  ]

  signing_key = authentik_certificate_key_pair.sso.id

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  property_mappings = data.authentik_property_mapping_provider_scope.oidc.ids
}

resource "authentik_application" "grafana" {
  name  = "Grafana"
  slug  = "grafana"
  group = "Monitoring"

  protocol_provider = authentik_provider_oauth2.grafana.id

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

data "authentik_provider_oauth2_config" "grafana" {
  provider_id = authentik_provider_oauth2.grafana.id
}

resource "authentik_policy_binding" "grafana_group_admins" {
  target = authentik_application.grafana.uuid
  group  = authentik_group.grafana_admins.id
  order  = 0
}
