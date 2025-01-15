resource "authentik_provider_proxy" "torrent" {
  name = "torrent"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  external_host = "http://torrent.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "torrent" {
  name  = "Torrent"
  slug  = "torrent"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.torrent.id

  meta_description = "Deluge is a light weight Torrent client."
  meta_icon        = "/static/dist/media/deluge.png"
  meta_publisher   = "Deluge"
}

resource "authentik_policy_binding" "torrent_media_admins" {
  target = authentik_application.torrent.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
