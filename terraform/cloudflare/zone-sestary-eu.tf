resource "cloudflare_zone" "sestary_eu" {
  account = {
    id = data.cloudflare_accounts.sestary.result[0].id
  }

  name = "sestary.eu"
}

# Note: A bunch of the records in this zone are managed Dynamically

# CAA Records
resource "cloudflare_dns_record" "caa_email" {
  zone_id = cloudflare_zone.sestary_eu.id

  name = "sestary.eu"
  data = {
    flags = 0
    tag   = "iodef"
    value = "mailto:systems@sestary.eu"
  }
  type = "CAA"

  proxied = false

  ttl = 3600
}

resource "cloudflare_dns_record" "caa_letsencrypt" {
  zone_id = cloudflare_zone.sestary_eu.id

  name = "sestary.eu"
  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
  type = "CAA"

  proxied = false

  ttl = 3600
}

# Localhost Record
resource "cloudflare_dns_record" "localhost" {
  zone_id = cloudflare_zone.sestary_eu.id

  name    = "localhost.sestary.eu"
  content = "127.0.0.1"
  type    = "A"

  proxied = false

  ttl = 3600
}

# Grafana
resource "cloudflare_dns_record" "grafana" {
  zone_id = cloudflare_zone.sestary_eu.id

  name    = "grafana.sestary.eu"
  content = "sestary.grafana.net"
  type    = "CNAME"

  proxied = false

  ttl = 3600
}

# Public Services
resource "cloudflare_dns_record" "requests" {
  zone_id = cloudflare_zone.sestary_eu.id

  name    = "requests.sestary.eu"
  content = "gw.on.sestary.eu"
  type    = "CNAME"

  proxied = true

  ttl = 3600
}

resource "cloudflare_dns_record" "sso" {
  zone_id = cloudflare_zone.sestary_eu.id

  name    = "sso.sestary.eu"
  content = "gw.on.sestary.eu"
  type    = "CNAME"

  proxied = true

  ttl = 3600
}

