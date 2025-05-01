resource "grafana_cloud_private_data_source_connect_network" "on" {
  name         = "sestary-on"
  display_name = "SeStary - Ontario"

  stack_identifier = grafana_cloud_stack.sestary.id
  region           = grafana_cloud_stack.sestary.region_slug
}

resource "grafana_cloud_private_data_source_connect_network_token" "on" {
  pdc_network_id = grafana_cloud_private_data_source_connect_network.on.pdc_network_id
  region         = grafana_cloud_private_data_source_connect_network.on.region

  name         = "pdc-on"
  display_name = "PDC PDC Token Ontario"
}
