resource "authentik_provider_proxy" "qbittorrent" {
  name = "qbittorrent"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://qbittorrent.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "qbittorrent" {
  name  = "QBitTorrent"
  slug  = "qbittorrent"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.qbittorrent.id

  meta_description = "QBitTorrent is a powerful torrent client."
  meta_icon        = "/static/dist/media/qbittorrent.jpg"
  meta_publisher   = "QBitTorrent"
}

resource "authentik_policy_binding" "qbittorrent_media_admins" {
  target = authentik_application.qbittorrent.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
