variable "charts_version" {
  description = "The helm chart versions"
  type        = map(string)
}

variable "plugins_version" {
  description = "The ArgoCD plugins versions"
  type        = map(string)
}
