resource "authentik_application" "truenas_nas1_on" {
  name  = "Ontario TrueNAS 1"
  slug  = "truenas-nas1-on"
  group = "Storage"

  meta_description = "TrueNAS SCALE is an Open Source Hyperconverged Infrastructure solution."
  meta_icon        = "/static/dist/media/truenas.png"
  meta_launch_url  = "https://nas1.on.sestary.eu"

  meta_publisher = "TrueNAS"
}

resource "authentik_application" "truenas_nas2_on" {
  name  = "Ontario TrueNAS 2"
  slug  = "truenas-nas2-on"
  group = "Storage"

  meta_description = "TrueNAS SCALE is an Open Source Hyperconverged Infrastructure solution."
  meta_icon        = "/static/dist/media/truenas.png"
  meta_launch_url  = "https://nas2.on.sestary.eu"
  meta_publisher   = "TrueNAS"
}

resource "authentik_application" "truenas_nas1_mi" {
  name  = "Michigan TrueNAS 1"
  slug  = "truenas-nas2-mi"
  group = "Storage"

  meta_description = "TrueNAS SCALE is an Open Source Hyperconverged Infrastructure solution."
  meta_icon        = "/static/dist/media/truenas.png"
  meta_launch_url  = "https://nas1.mi.sestary.eu"
  meta_publisher   = "TrueNAS"
}

resource "authentik_group" "truenas_admins" {
  name = "truenas-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "truenas_nas1_on_group_admins" {
  target = authentik_application.truenas_nas1_on.uuid
  group  = authentik_group.truenas_admins.id
  order  = 0
}

resource "authentik_policy_binding" "truenas_nas2_on_group_admins" {
  target = authentik_application.truenas_nas2_on.uuid
  group  = authentik_group.truenas_admins.id
  order  = 0
}

resource "authentik_policy_binding" "truenas_nas1_mi_group_admins" {
  target = authentik_application.truenas_nas1_mi.uuid
  group  = authentik_group.truenas_admins.id
  order  = 0
}
