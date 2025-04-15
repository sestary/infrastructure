resource "authentik_application" "jellyseerr" {
  name  = "Requests"
  slug  = "jellyseerr"
  group = "Media"

  meta_description = "Request new Movies and TV Shows"
  meta_icon        = "/static/dist/media/jellyseerr.png"
  meta_launch_url  = "https://requests.sestary.eu/"
  meta_publisher   = "JellySeerr"
}

resource "authentik_group" "jellyseerr_admins" {
  name = "jellyseerr-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}
