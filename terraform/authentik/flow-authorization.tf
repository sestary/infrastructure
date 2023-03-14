resource "authentik_flow" "authorization_implicit_consent" {
  name        = "Authorize Application"
  title       = "Logging you into %(app)"
  slug        = "sestary-authorization-implicit-consent"
  designation = "authorization"

  background = "/static/dist/media/background.jpg"
}
