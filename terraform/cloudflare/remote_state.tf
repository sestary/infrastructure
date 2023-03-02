terraform {
  cloud {
    organization = "SeStary"

    workspaces {
      name = "Cloudflare"
    }
  }
}
