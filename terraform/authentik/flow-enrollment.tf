resource "authentik_flow" "enrollment_invite" {
  name        = "sestary-enrollment-invite"
  title       = "Sign Up"
  slug        = "sestary-enrollment-invite"
  designation = "enrollment"

  layout = "sidebar_left"

  background = "/static/dist/media/background.jpg"
}

# Invitation Verification
resource "authentik_stage_invitation" "enrollment_invitation" {
  name = "sestary-enrollment-invitation"

  continue_flow_without_invitation = false
}

resource "authentik_flow_stage_binding" "enrollment_invitation" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_invitation.enrollment_invitation.id
  order  = 0
}

# Prompt to fill out user details
resource "authentik_stage_prompt" "enrollment_user_details" {
  name = "sestary-enrollment-user-details"
  fields = [
    resource.authentik_stage_prompt_field.name.id,
    resource.authentik_stage_prompt_field.username.id,
    resource.authentik_stage_prompt_field.email.id,
    resource.authentik_stage_prompt_field.password.id,
    resource.authentik_stage_prompt_field.password_confirm.id,
  ]
}

resource "authentik_flow_stage_binding" "enrollment_user_details" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_prompt.enrollment_user_details.id
  order  = 10
}

# Write the user
resource "authentik_stage_user_write" "enrollment_user_write" {
  name = "sestary-enrollment-user-write"

  create_users_as_inactive = true
}

resource "authentik_flow_stage_binding" "enrollment_write_user" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_user_write.enrollment_user_write.id
  order  = 15
}

# Sends email verification
resource "authentik_stage_email" "enrollment_verification" {
  name = "sestary-email-enrollment-verification"

  activate_user_on_success = true
  template                 = "email/account_confirmation.html"
}

resource "authentik_flow_stage_binding" "enrollment_email_verification" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_email.enrollment_verification.id
  order  = 20
}

# MFA enrollment
resource "authentik_flow_stage_binding" "enrollment_mfa_totp_setup" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_authenticator_totp.main_mfa_setup.id
  order  = 30
}

resource "authentik_flow_stage_binding" "enrollment_mfa_static_setup" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_authenticator_totp.main_mfa_setup.id
  order  = 35
}

# Log the user in
resource "authentik_stage_user_login" "enrollment_user_login" {
  name = "sestary-enrollment-user-login"
}

resource "authentik_flow_stage_binding" "enrollment_user_login" {
  target = authentik_flow.enrollment_invite.uuid
  stage  = authentik_stage_user_login.enrollment_user_login.id
  order  = 40
}
