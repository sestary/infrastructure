resource "authentik_tenant" "sestary" {
  domain  = "sso.sestary.eu"

  branding_title   = "SeStary"
  branding_logo    = "/media/sestary/logo.png"
  branding_favicon = "/media/sestary/favicon.ico"

  flow_authentication = authentik_flow.authentication.uuid
}
