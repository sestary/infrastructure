provider "grafana" {
  alias                     = "cloud"
  cloud_access_policy_token = var.cloud_access_token
}

provider "grafana" {
  url  = grafana_cloud_stack.sestary.url
  auth = grafana_cloud_stack_service_account_token.sestary.key
}
