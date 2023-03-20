resource "authentik_provider_proxy" "radarr" {
  name = "radarr"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://radarr.sestary.eu"
}

resource "authentik_application" "radarr" {
  name  = "Radarr"
  slug  = "radarr"
  group = "Media"

  protocol_provider = authentik_provider_proxy.radarr.id

  meta_description = "Manage Movies"
  meta_icon        = "/static/dist/media/radarr.png"
  meta_publisher   = "Radarr"
}

resource "authentik_policy_binding" "radarr_media_admins" {
  target = authentik_application.radarr.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
