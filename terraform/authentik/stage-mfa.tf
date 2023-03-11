resource "authentik_stage_authenticator_totp" "main_mfa_setup" {
  name = "main-mfa-totp-setup"
}

resource "authentik_stage_authenticator_static" "main_mfa_setup" {
  name = "main-mfa-static-setup"
}

