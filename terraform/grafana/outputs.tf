output "pdc_tokens" {
  description = "Private Datacenter Connection Tokens"
  value = {
    "on" : grafana_cloud_private_data_source_connect_network_token.on.token
  }
  sensitive = true
}
