resource "authentik_provider_proxy" "prowlarr" {
  name = "prowlarr"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://prowlarr.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "prowlarr" {
  name  = "Prowlarr"
  slug  = "prowlarr"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.prowlarr.id

  meta_description = "Manage Torrent Search Providers"
  meta_icon        = "/static/dist/media/prowlarr.png"
  meta_publisher   = "Prowlarr"
}

resource "authentik_policy_binding" "prowlarr_media_admins" {
  target = authentik_application.prowlarr.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
