resource "grafana_data_source" "prometheus" {
  type                = "prometheus"
  name                = "Sestary - Prometheus"
  url                 = "http://prometheus-kube-prometheus-prometheus.monitoring-prometheus.svc.cluster.local:9090"

  json_data_encoded = jsonencode({
    httpMethod        = "POST"
    prometheusType    = "Prometheus"
    prometheusVersion = "3.3.0"
  })
 }
