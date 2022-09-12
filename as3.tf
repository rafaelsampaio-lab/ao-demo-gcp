locals {
  juiceshop-vars = {
    app_tenant    = "ecommerce"
    app_name      = "juiceshop"
    app_address   = var.app-address
    app_node_port = "8000"

    #Part 1: Basic app (appBasic.json.tpl)
    #app_nodes = ["10.1.20.2", "10.1.20.3"]

    #Part 2: App with Service Discovery and TLS (appServiceDiscoveryTLS.json.tpl)
    app_tag         = "rsampaio-app"
    app_region      = "southamerica-east1"
    app_certificate = replace(tls_self_signed_cert.juiceshop-certificate.cert_pem, "/\n/", "\\n")
    app_private_key = replace(tls_private_key.juiceshop-private-key.private_key_pem, "/\n/", "\\n")
    app_waf = "https://raw.githubusercontent.com/rafaelsampaio-lab/ao-demo-gcp/main/waf-policy.json"
    
    network_dos_vectors = local.dos-network-vectors-settings
  }

  #juiceshop-as3 = templatefile("${path.module}/juiceshop-basic.json.tftpl", local.juiceshop-vars)
  juiceshop-as3 = templatefile("${path.module}/juiceshop-full.json.tftpl", local.juiceshop-vars)
}

resource "bigip_as3" "juiceshop" {
  as3_json = local.juiceshop-as3
}

