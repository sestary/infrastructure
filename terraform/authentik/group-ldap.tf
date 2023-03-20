resource "authentik_group" "ldap_search" {
  name = "ldap-search"

  lifecycle {
    ignore_changes = [
      users,
    ]
  }
}
