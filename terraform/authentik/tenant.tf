resource "authentik_tenant" "sestary" {
  domain = "sso.sestary.eu"

  branding_title   = "SeStary"
  branding_logo    = "/static/dist/media/logo.png"
  branding_favicon = "/static/dist/media/favicon.ico"

  flow_authentication = authentik_flow.authentication.uuid
}
