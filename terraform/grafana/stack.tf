resource "grafana_cloud_stack" "sestary" {
  provider = grafana.cloud

  name        = "SeStary"
  slug        = "sestary"
  region_slug = "eu"

  url = "https://grafana.sestary.eu"
}

resource "grafana_cloud_stack_service_account" "terraform" {
  provider = grafana.cloud

  stack_slug = grafana_cloud_stack.sestary.slug

  name = "Terraform Service Account"
  role = "Admin"

  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "terraform" {
  provider = grafana.cloud

  stack_slug = grafana_cloud_stack.sestary.slug

  name               = "Terraform Service Account"
  service_account_id = grafana_cloud_stack_service_account.terraform.id
}

