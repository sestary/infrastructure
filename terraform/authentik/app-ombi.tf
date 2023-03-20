resource "authentik_provider_proxy" "ombi" {
  name = "ombi"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://ombi.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "ombi" {
  name  = "OMBI"
  slug  = "ombi"
  group = "Media"

  protocol_provider = authentik_provider_proxy.ombi.id

  meta_description = "Request new Movies and TV Shows"
  meta_icon        = "/static/dist/media/ombi.png"
  meta_publisher   = "OMBI"
}
