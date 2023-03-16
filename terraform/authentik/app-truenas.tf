resource "authentik_application" "truenas_nas1" {
  name  = "TrueNAS 1"
  slug  = "truenas-nas1"
  group = "Systems"

  meta_description = "TrueNAS SCALE is an Open Source Hyperconverged Infrastructure solution."
  meta_icon        = "/static/dist/media/truenas.png"
  meta_launch_url  = "https://nas.on.sestary.eu" # This is wrong right now waiting for this fix to go in https://github.com/goauthentik/authentik/pull/4957
 
  meta_publisher   = "TrueNAS"
}

resource "authentik_application" "truenas_nas2" {
  name  = "TrueNAS 2"
  slug  = "truenas-nas2"
  group = "Systems"

  meta_description = "TrueNAS SCALE is an Open Source Hyperconverged Infrastructure solution."
  meta_icon        = "/static/dist/media/truenas.png"
  meta_launch_url  = "https://nas.on.sestary.eu" # This is wrong right now waiting for this fix to go in https://github.com/goauthentik/authentik/pull/4957
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

resource "authentik_policy_binding" "truenas_nas1_group_admins" {
  target = authentik_application.truenas_nas1.uuid
  group  = authentik_group.truenas_admins.id
  order  = 0
}

resource "authentik_policy_binding" "truenas_nas2_group_admins" {
  target = authentik_application.truenas_nas2.uuid
  group  = authentik_group.truenas_admins.id
  order  = 0
}
