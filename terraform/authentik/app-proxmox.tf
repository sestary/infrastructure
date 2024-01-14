resource "random_password" "client_secret_proxmox" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "proxmox" {
  name          = "proxmox"
  client_id     = "proxmox"
  client_secret = random_password.client_secret_proxmox.result

  redirect_uris = [
    "https://pve.on.sestary.eu:8006",
  ]

  signing_key = authentik_certificate_key_pair.sso.id

  authorization_flow = authentik_flow.authorization_implicit_consent.uuid

  property_mappings = data.authentik_scope_mapping.oidc.ids
}

resource "authentik_application" "proxmox" {
  name  = "Proxmox VE"
  slug  = "proxmox"
  group = "Infrastructure"

  protocol_provider = authentik_provider_oauth2.proxmox.id

  meta_description = "Proxmox Virtual Environment is a hyper-converged infrastructure open-source software."
  meta_icon        = "/static/dist/media/proxmox.png"
  meta_launch_url  = "https://pve.on.sestary.eu:8006"
  meta_publisher   = "Proxmox"
}

resource "authentik_group" "proxmox_admins" {
  name = "proxmox-admins"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}

resource "authentik_policy_binding" "proxmox_on_group_admins" {
  target = authentik_application.proxmox.uuid
  group  = authentik_group.proxmox_admins.id
  order  = 0
}
