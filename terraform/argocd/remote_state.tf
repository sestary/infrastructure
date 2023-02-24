terraform {
  cloud {
    organization = "SeStary"

    workspaces {
      name = "ArgoCD"
    }
  }
}
