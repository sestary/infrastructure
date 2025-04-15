resource "random_password" "client_secret_argocd" {
  length  = 40
  special = false
}

moved {
  from = random_password.client_secret
  to = random_password.client_secret_argocd
}

resource "authentik_provider_oauth2" "argocd" {
  name          = "argocd"
  client_id     = "argocd"
  client_secret = random_password.client_secret_argocd.result

  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = "https://argocd.sestary.eu/api/dex/callback",
    },
    {
      matching_mode = "strict",
      url           = "http://localhost:8085/auth/callback",
    },
  ]

  signing_key = authentik_certificate_key_pair.sso.id

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid
  invalidation_flow  = authentik_flow.invalidation.uuid

  property_mappings = data.authentik_property_mapping_provider_scope.oidc.ids
}

resource "authentik_application" "argocd" {
  name  = "ArgoCD"
  slug  = "argocd"
  group = "Kubernetes"

  protocol_provider = authentik_provider_oauth2.argocd.id

  meta_description = "Declarative continuous delivery with a fully-loaded UI."
  meta_icon        = "/static/dist/media/argocd.png"
  meta_launch_url  = "https://argocd.sestary.eu/auth/login?return_url=https%3A%2F%2Fargocd.sestary.eu%2Fapplications"
  meta_publisher   = "ArgoCD"
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

resource "authentik_policy_binding" "argocd_group_admins" {
  target = authentik_application.argocd.uuid
  group  = authentik_group.argocd_admins.id
  order  = 0
}
