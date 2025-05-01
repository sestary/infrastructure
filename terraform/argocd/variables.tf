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

variable "plugins_image_tag" {
  description = "The ArgoCD plugins image tag"
  type        = string
}

variable "kube_client_cert" {
  description = "Kubernetes Client Certicate"
  type        = string
}

variable "kube_client_key" {
  description = "Kubernetes Client Key"
  type        = string
}

variable "kube_ca_cert" {
  description = "Kubernetes CA Certificate"
  type        = string
}

variable "kube_host" {
  description = "Kubernetes API Host"
  type        = string
  default     = "https://kube.on.sestary.eu:16443"
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

variable "sops_key" {
  description = "ArgoCD SOPS Plugin Decryption Key"
  type        = string
  default     = null
}
