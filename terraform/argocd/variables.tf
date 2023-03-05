variable "enable_ingress" {
  description = "This allows you to disable the ArgoCD ingress resource"
  type        = bool
  default     = true
}

variable "enable_oidc" {
  description = "This allows you to disable the OIDC integration"
  type        = bool
  default     = false
}

variable "enable_service_monitor" {
  description = "This allows you to disable the Prometheus Service Monitor"
  type        = bool
  default     = false
}

variable "charts_version" {
  description = "The helm chart versions"
  type        = map(string)
}

variable "plugins_version" {
  description = "The ArgoCD plugins versions"
  type        = map(string)
}
