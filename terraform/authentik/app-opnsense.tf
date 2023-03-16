resource "authentik_application" "opnsense_on" {
  name  = "Ontario OPNSense"
  slug  = "opnsense_on"
  group = "Systems"

  meta_description = "Secure Your Network with ease"
  meta_icon        = "/static/dist/media/opnsense.png"
  meta_launch_url  = "https://opnsense.on.sestary.eu"
  meta_publisher   = "OPNSense"
}

resource "authentik_application" "opnsense_mi" {
  name  = "Michigan OPNSense"
  slug  = "opnsense_mi"
  group = "Systems"

  meta_description = "Secure Your Network with ease"
  meta_icon        = "/static/dist/media/opnsense.png"
  meta_launch_url  = "https://opnsense.mi.sestary.eu"
  meta_publisher   = "OPNSense"
}

resource "authentik_application" "opnsense_mx" {
  name  = "Mexico OPNSense"
  slug  = "opnsense_mx"
  group = "Systems"

  meta_description = "Secure Your Network with ease"
  meta_icon        = "/static/dist/media/opnsense.png"
  meta_launch_url  = "https://opnsense.mx.sestary.eu"
  meta_publisher   = "OPNSense"
}

resource "authentik_application" "opnsense_pt" {
  name  = "Petrolia OPNSense"
  slug  = "opnsense_pt"
  group = "Systems"

  meta_description = "Secure Your Network with ease"
  meta_icon        = "/static/dist/media/opnsense.png"
  meta_launch_url  = "https://opnsense.pt.sestary.eu"
  meta_publisher   = "OPNSense"
}

resource "authentik_group" "opnsense_admins" {
  name = "opnsense-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "opnsense_on_group_admins" {
  target = authentik_application.opnsense_on.uuid
  group  = authentik_group.opnsense_admins.id
  order  = 0
}

resource "authentik_policy_binding" "opnsense_mi_group_admins" {
  target = authentik_application.opnsense_mi.uuid
  group  = authentik_group.opnsense_admins.id
  order  = 0
}

resource "authentik_policy_binding" "opnsense_mx_group_admins" {
  target = authentik_application.opnsense_pt.uuid
  group  = authentik_group.opnsense_admins.id
  order  = 0
}

resource "authentik_policy_binding" "opnsense_pt_group_admins" {
  target = authentik_application.opnsense_pt.uuid
  group  = authentik_group.opnsense_admins.id
  order  = 0
}
