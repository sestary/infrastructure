resource "authentik_provider_proxy" "longhorn" {
  name = "longhorn"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://longhorn.sestary.eu"
}

resource "authentik_application" "longhorn" {
  name  = "Longhorn"
  slug  = "longhorn"
  group = "Systems"

  protocol_provider = authentik_provider_proxy.longhorn.id

  meta_description = "Cloud native distributed block storage for Kubernetes"
  meta_icon        = "/static/dist/media/longhorn.png"
  meta_publisher   = "Longhorn"
}

resource "authentik_group" "longhorn_admins" {
  name = "longhorn-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "longhorn_group_admins" {
  target = authentik_application.longhorn.uuid
  group  = authentik_group.longhorn_admins.id
  order  = 0
}
