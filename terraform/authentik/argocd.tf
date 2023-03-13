resource "random_password" "client_secret" {
  length           = 40
  special          = false
}

resource "authentik_provider_oauth2" "argocd" {
  name      = "argocd"
  client_id = "argocd"
  client_secret = random_password.client_secret.result 

  redirect_uris = [
    "https://argocd.on.sestary.eu/api/dex/callback",
    "http://localhost:8085/auth/callback",
  ]

  signing_key = authentik_certificate_key_pair.sso.id

  authorization_flow = data.authentik_flow.default_authorization_flow.id
}

resource "authentik_application" "argocd" {
  name              = "ArgoCD"
  slug              = "argocd"
  group = "Systems"

  protocol_provider = authentik_provider_oauth2.argocd.id

  meta_description = "Declarative continuous delivery with a fully-loaded UI."
  meta_icon = "/static/dist/media/argocd.png"
  meta_launch_url = "https://argocd.on.sestary.eu/auth/login?return_url=https%3A%2F%2Fargocd.on.sestary.eu%2Fapplications"
  meta_publisher = "ArgoCD"
}

resource "authentik_group" "argocd_admins" {
  name = "argocd-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

data "authentik_provider_oauth2_config" "argocd" {
  provider_id = authentik_provider_oauth2.argocd.id
}
