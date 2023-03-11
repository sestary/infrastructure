resource "authentik_stage_prompt_field" "name" {
  name = "sestary-name"

  field_key = "name"
  label     = "What's your name?"
  type      = "text"

  order = 100
}

resource "authentik_stage_prompt_field" "username" {
  name = "sestary-username"

  field_key = "username"
  label     = "What username do you want?"
  type      = "username"

  order = 110
}

resource "authentik_stage_prompt_field" "email" {
  name = "sestary-email"

  field_key = "email"
  label     = "What's your email address?"
  type      = "email"

  order = 200
}

resource "authentik_stage_prompt_field" "password" {
  name = "sestary-password"

  field_key = "password"
  label     = "Set a password"
  type      = "password"

  order = 300
}

resource "authentik_stage_prompt_field" "password_confirm" {
  name = "sestary-password-confirm"

  field_key = "password-repeat"
  label     = "Confirm your password"
  type      = "password"

  order = 310
}
