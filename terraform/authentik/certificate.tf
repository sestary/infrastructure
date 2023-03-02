resource "tls_private_key" "sso" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "sso" {
  private_key_pem = tls_private_key.sso.private_key_pem

  subject {
    common_name  = "sso.sestary.eu"
    organization = "SeStary"
  }

  validity_period_hours = 87658 # 10 Years

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "authentik_certificate_key_pair" "sso" {
  name             = "sso"
  certificate_data = tls_self_signed_cert.sso.cert_pem
  key_data         = tls_private_key.sso.private_key_pem
}
