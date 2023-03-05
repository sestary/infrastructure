resource "authentik_provider_oauth2" "argocd" {
  name      = "argocd"
  client_id = "argocd"

  redirect_uris = [
    "http://argocd.on.sestary.eu/api/dex/callback",
    "http://localhost:8085/auth/callback",
  ]

  signing_key = authentik_certificate_key_pair.sso.name
}

resource "authentik_application" "argocd" {
  name              = "ArgoCD"
  slug              = "argocd"
  protocol_provider = authentik_provider_oauth2.argocd.id
}

resource "authentik_group" "argocd_admins" {
  name = "argo-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

data "authentik_provider_oauth2_config" "argocd" {
  provider_id = authentik_provider_oauth2.argocd.id
}
