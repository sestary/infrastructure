resource "random_password" "client_secret_jellyseerr" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "jellyseerr" {
  name          = "jellyseerr"
  client_id     = "jellyseerr"
  client_secret = random_password.client_secret.result

  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = "http://requests.sestary.eu/login/oidc/callback",
    },
    {
      matching_mode = "strict",
      url           = "https://requests.sestary.eu/login/oidc/callback",
    }
  ]

  signing_key = authentik_certificate_key_pair.sso.id

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  property_mappings = data.authentik_property_mapping_provider_scope.oidc.ids
}

resource "authentik_application" "jellyseerr" {
  name  = "Requests"
  slug  = "jellyseerr"
  group = "Media"

  protocol_provider = authentik_provider_oauth2.jellyseerr.id

  meta_description = "Request new Movies and TV Shows"
  meta_icon        = "/static/dist/media/jellyseerr.png"
  meta_launch_url  = "https://requests.sestary.eu/api/v1/auth/oidc-login"
  meta_publisher   = "JellySeerr"
}

resource "authentik_group" "jellyseerr_admins" {
  name = "jellyseerr-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}
