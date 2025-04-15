output "argocd_oidc" {
  description = "ArgoCD OIDC config"
  sensitive   = true

  value = {
    issuer        = data.authentik_provider_oauth2_config.argocd.issuer_url
    client_id     = authentik_provider_oauth2.argocd.client_id
    client_secret = authentik_provider_oauth2.argocd.client_secret
  }
}

output "grafana_oidc" {
  description = "Grafana OIDC config"
  sensitive   = true

  value = {
    issuer        = data.authentik_provider_oauth2_config.grafana.issuer_url
    client_id     = authentik_provider_oauth2.grafana.client_id
    client_secret = authentik_provider_oauth2.grafana.client_secret
  }
}

output "proxmox_oidc" {
  description = "Proxmox OIDC config"
  sensitive   = true

  value = {
    issuer        = data.authentik_provider_oauth2_config.proxmox.issuer_url
    client_id     = authentik_provider_oauth2.proxmox.client_id
    client_secret = authentik_provider_oauth2.proxmox.client_secret
  }
}
