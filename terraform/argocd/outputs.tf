output "argocd_admin_password" {
  description = "The ArgoCD Admin Password"
  value       = data.kubernetes_secret_v1.argocd_initial_password.data.password
  sensitive   = true
}

