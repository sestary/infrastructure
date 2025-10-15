provider "helm" {
  kubernetes = {
    host = var.kube_host

    client_certificate     = var.kube_client_cert
    client_key             = var.kube_client_key
    cluster_ca_certificate = var.kube_ca_cert
  }
}

provider "kubernetes" {
  host = var.kube_host

  client_certificate     = var.kube_client_cert
  client_key             = var.kube_client_key
  cluster_ca_certificate = var.kube_ca_cert
}
