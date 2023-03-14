resource "authentik_flow" "invalidation" {
  name        = "Logout"
  title       = "Logging out"
  slug        = "sestary-invalidation"
  designation = "invalidation"

  background = "/static/dist/media/background.jpg"
}

resource "authentik_stage_user_logout" "invalidation" {
  name = "sestary-user-logout"
}

resource "authentik_flow_stage_binding" "invalidation" {
  target = authentik_flow.invalidation.uuid
  stage  = authentik_stage_user_logout.invalidation.id
  order  = 10
}
