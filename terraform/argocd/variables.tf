variable "enable_ingress" {
  description = "This allows you to disable the ArgoCD ingress resource"
  type        = bool
  default     = false
}

variable "enable_oidc" {
  description = "This allows you to disable the OIDC integration"
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

variable "log_level_services" {
  description = "The service specific log levels"
  type        = map(string)
  default     = {}
}

variable "log_level_default" {
  description = "The default log level"
  type        = string
  default     = "warn"
}
