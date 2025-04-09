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

# Public Services
resource "cloudflare_record" "requests" {
  zone_id = cloudflare_zone.sestary_eu.id

  name  = "requests.sestary.eu"
  value = "gw.on.sestary.eu"
  type  = "CNAME"

  proxied = true
}

resource "cloudflare_record" "sso" {
  zone_id = cloudflare_zone.sestary_eu.id

  name  = "sso.sestary.eu"
  value = "gw.on.sestary.eu"
  type  = "CNAME"

  proxied = true
}

