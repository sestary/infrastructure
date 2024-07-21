resource "authentik_brand" "sestary" {
  domain = "sso.sestary.eu"

  branding_title   = "SeStary"
  branding_logo    = "/static/dist/media/logo.png"
  branding_favicon = "/static/dist/media/favicon.ico"

  flow_authentication = authentik_flow.authentication.uuid
  flow_invalidation   = authentik_flow.invalidation.uuid
}
