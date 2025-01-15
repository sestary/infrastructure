resource "authentik_provider_proxy" "solverr" {
  name = "solverr"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  external_host = "http://solverr.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "solverr" {
  name  = "solverr"
  slug  = "solverr"
  group = "Media Tools"

  protocol_provider = authentik_provider_proxy.solverr.id

  meta_description = "Solve Torrent Search Providers Cloudflare Captcha"
  meta_icon        = "/static/dist/media/solverr.png"
  meta_publisher   = "solverr"
}

resource "authentik_policy_binding" "solverr_media_admins" {
  target = authentik_application.solverr.uuid
  group  = authentik_group.media_admins.id
  order  = 0
}
