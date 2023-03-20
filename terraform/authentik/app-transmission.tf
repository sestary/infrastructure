resource "authentik_provider_proxy" "transmission" {
  name = "transmission"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://transmission.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "transmission" {
  name  = "Transmission"
  slug  = "transmission"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.transmission.id

  meta_description = "Transmission is an easy, powerful torrent client."
  meta_icon        = "/static/dist/media/transmission.png"
  meta_publisher   = "Transmission"
}

resource "authentik_policy_binding" "transmission_media_admins" {
  target = authentik_application.transmission.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
