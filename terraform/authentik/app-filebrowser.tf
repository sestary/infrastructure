resource "authentik_provider_proxy" "filebrowser" {
  name = "filebrowser"

  mode = "forward_single"

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  external_host = "http://filebrowser.sestary.eu"

  access_token_validity = "hours=8"
}

resource "authentik_application" "filebrowser" {
  name  = "File Broswer"
  slug  = "filebrowser"
  group = "Storage"

  protocol_provider = authentik_provider_proxy.filebrowser.id

  meta_description = "Manage the files on TrueNAS"
  meta_icon        = "/static/dist/media/filebrowser.png"
  meta_publisher   = "File Browser"
}

resource "authentik_group" "filebrowser_admins" {
  name = "filebrowser-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "filebrowser_group_admins" {
  target = authentik_application.filebrowser.uuid
  group  = authentik_group.filebrowser_admins.id
  order  = 0
}
