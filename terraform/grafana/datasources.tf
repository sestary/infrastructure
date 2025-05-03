resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "Sestary - Prometheus"
  url  = "http://prometheus-kube-prometheus-prometheus.monitoring-prometheus.svc.cluster.local:9090"

  json_data_encoded = jsonencode({
    cacheLevel        = "High",
    httpMethod        = "POST",
    prometheusType    = "Prometheus",
    prometheusVersion = "2.50.1"

    enableSecureSocksProxy   = true
    secureSocksProxyUsername = grafana_cloud_private_data_source_connect_network.on.pdc_network_id
  })

  private_data_source_connect_network_id = grafana_cloud_private_data_source_connect_network.on.id
}
