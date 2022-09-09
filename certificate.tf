resource "tls_private_key" "juiceshop-private-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "juiceshop-certificate" {
  private_key_pem = tls_private_key.juiceshop-private-key.private_key_pem

  subject {
    common_name         = "juiceshop.example.com"
    organization        = "F5, Inc."
    organizational_unit = "Automation & Orchestration Toolchain Demo"
  }

  validity_period_hours = 24

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}