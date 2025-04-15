terraform {
  cloud {
    organization = "SeStary"

    workspaces {
      name = "Grafana"
    }
  }
}
