output "argocd_oidc" {
  description = "ArgoCD OIDC config"

  value = {
    issuer        = data.authentik_provider_oauth2_config.argocd.issuer_url
    client_id     = authentik_provider_oauth2.argocd.client_id
    client_secret = authentik_provider_oauth2.argocd.client_secret
  }
}
