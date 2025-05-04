locals {
  dashboard_import_ids = {
    "UniFi Sites" : {
      id : 11311,
      revision : 5,
      folder : grafana_folder.unifi.uid,
    },
    "UniFi Switch" : {
      id : 11312,
      revision : 9,
      folder : grafana_folder.unifi.uid,
    },
    "UniFi Access Points" : {
      id : 11314
      revision : 10
      folder : grafana_folder.unifi.uid,
    },
    "UniFi Clients" : {
      id : 11315,
      revision : 9,
      folder : grafana_folder.unifi.uid,
    }
  }
}

data "http" "imports" {
  for_each = local.dashboard_import_ids

  url = "https://grafana.com/api/dashboards/${each.value.id}/revisions/${each.value.revision}/download"
}

resource "grafana_dashboard" "imports" {
  for_each = local.dashboard_import_ids

  folder = each.value.folder
  config_json = jsonencode(
    merge(
      {
        "title" : each.key,
      },
      jsondecode(
        data.http.imports[each.key].response_body
      )
    )
  )
}
