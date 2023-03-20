resource "authentik_group" "media_admins" {
  name = "media-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}
