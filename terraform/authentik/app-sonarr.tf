resource "authentik_provider_proxy" "sonarr" {
  name = "sonarr"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://sonarr.sestary.eu"
}

resource "authentik_application" "sonarr" {
  name  = "Sonarr"
  slug  = "sonarr"
  group = "Media"

  protocol_provider = authentik_provider_proxy.sonarr.id

  meta_description = "Manage TV shows"
  meta_icon        = "/static/dist/media/sonarr.png"
  meta_publisher   = "sonarr"
}

resource "authentik_policy_binding" "sonarr_media_admins" {
  target = authentik_application.sonarr.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
