terraform {
  required_version = ">= 1.5.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 4.0"
    }
  }
}
