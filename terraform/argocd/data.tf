data "terraform_remote_state" "authentik" {
  count = var.enable_oidc ? 1 : 0

  backend = "remote"

  config = {
    organization = "SeStary"

    workspaces = {
      name = "Authentik"
    }
  }
}
