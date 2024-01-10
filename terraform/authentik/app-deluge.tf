resource "authentik_provider_proxy" "deluge" {
  name = "deluge"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://deluge.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "deluge" {
  name  = "Deluge"
  slug  = "deluge"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.deluge.id

  meta_description = "Deluge is a lightweight, Free Software, cross-platform BitTorrent client."
  meta_icon        = "/static/dist/media/deluge.jpg"
  meta_publisher   = "Deluge"
}

resource "authentik_policy_binding" "deluge_media_admins" {
  target = authentik_application.deluge.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
