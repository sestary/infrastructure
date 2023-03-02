resource "cloudflare_zone" "sestary_eu" {
  account_id = data.cloudflare_accounts.sestary.accounts[0].id
  zone       = "sestary.eu"
}

# Note: A bunch of the records in this zone are managed Dynamically

# CAA Records
resource "cloudflare_record" "caa_email" {
  zone_id = cloudflare_zone.sestary_eu.id

  name = "sestary.eu"
  data {
    flags = "0"
    tag   = "iodef"
    value = "mailto:systems@sestary.eu"
  }
  type = "CAA"

  proxied = false
}

resource "cloudflare_record" "caa_letsencrypt" {
  zone_id = cloudflare_zone.sestary_eu.id

  name = "sestary.eu"
  data {
    flags = "0"
    tag   = "issue"
    value = "letsencrypt.org"
  }
  type = "CAA"

  proxied = false
}

# MX Records
resource "cloudflare_record" "mx_10" {
  zone_id = cloudflare_zone.sestary_eu.id

  name     = "sestary.eu"
  value    = "spool.mail.gandi.net"
  type     = "MX"
  priority = 10

  proxied = false
}

resource "cloudflare_record" "mx_50" {
  zone_id = cloudflare_zone.sestary_eu.id

  name     = "sestary.eu"
  value    = "fb.mail.gandi.net"
  type     = "MX"
  priority = 50

  proxied = false
}

# TXT Records
resource "cloudflare_record" "txt_spf" {
  zone_id = cloudflare_zone.sestary_eu.id

  name  = "sestary.eu"
  value = "v=spf1 mx include:_mailcust.gandi.net -all"
  type  = "TXT"

  proxied = false
}

# Localhost Record
resource "cloudflare_record" "localhost" {
  zone_id = cloudflare_zone.sestary_eu.id

  name  = "localhost.sestary.eu"
  value = "127.0.0.1"
  type  = "A"

  proxied = false
}

# Grafana
resource "cloudflare_record" "grafana" {
  zone_id = cloudflare_zone.sestary_eu.id

  name  = "grafana.sestary.eu"
  value = "sestary.grafana.net"
  type  = "CNAME"

  proxied = false
}

