terraform {
  cloud {
    organization = "SeStary"

    workspaces {
      name = "Authentik"
    }
  }
}
