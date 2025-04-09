terraform {
  required_version = ">= 1.5.0"
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2025.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
