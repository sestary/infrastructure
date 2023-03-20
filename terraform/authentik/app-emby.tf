data "authentik_flow" "default-authentication-flow" {
  slug = "default-authentication-flow"
}

resource "authentik_provider_ldap" "emby" {
  name = "emby"

  base_dn   = "dc=emby"
  bind_flow = data.authentik_flow.default-authentication-flow.id
}

resource "authentik_application" "emby" {
  name  = "Emby"
  slug  = "emby"
  group = "Media"

  protocol_provider = authentik_provider_ldap.emby.id

  meta_description = "Watch Movies and TV Shows."
  meta_icon        = "/static/dist/media/emby.png"
  meta_publisher   = "Emby"
}
