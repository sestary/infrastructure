output "zone_ids" {
  description = "The Zone IDs"
  value = {
    "sestary.eu" = cloudflare_zone.sestary_eu.id
  }
}
