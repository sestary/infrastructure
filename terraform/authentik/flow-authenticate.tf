resource "authentik_flow" "authentication" {
  name        = "sestary-authenticate"
  title       = "Welcome! Please login"
  slug        = "sestary-authenticate"
  designation = "authentication"

  background = "/static/dist/media/background.jpg"
}

# Identification Stage
resource "authentik_stage_identification" "authentication_identification" {
  name           = "sestary-authentication-identification"
  user_fields    = ["username", "email"]
  sources        = [data.authentik_source.inbuilt.uuid]
  password_stage = authentik_stage_password.authentication_password.id
}

resource "authentik_flow_stage_binding" "authentication_identification" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_identification.authentication_identification.id
  order  = 0
}

data "authentik_source" "inbuilt" {
  managed = "goauthentik.io/sources/inbuilt"
}

# Password Prompt
resource "authentik_stage_password" "authentication_password" {
  name     = "sestary-authentication-password"
  backends = ["authentik.core.auth.InbuiltBackend"]
}

# MFA Validation
resource "authentik_stage_authenticator_validate" "authentication_mfa_validate" {
  name           = "sestary-authentication-mfa-validate"
  device_classes = ["static", "totp"]

  not_configured_action = "skip"
  #configuration_stages = [
  #  authentik_stage_authenticator_totp.main_mfa_setup.id,
  #  authentik_stage_authenticator_static.main_mfa_setup.id,
  #]
}

resource "authentik_flow_stage_binding" "authentication_mfa_validate" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_authenticator_validate.authentication_mfa_validate.id
  order  = 10
}

# User Login
resource "authentik_stage_user_login" "authentication_user_login" {
  name = "sestary-authentication-user-login"
}

resource "authentik_flow_stage_binding" "authentication_user_login" {
  target = authentik_flow.authentication.uuid
  stage  = authentik_stage_user_login.authentication_user_login.id
  order  = 20
}
