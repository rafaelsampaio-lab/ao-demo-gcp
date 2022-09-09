data "template_file" "juiceshop-declaration" {
  #Part 1: Basic app (juiceshop-basic.json.tpl)
  template = file("${path.module}/juiceshop-basic.json.tftpl")

  #Part 2: App with Service Discovery and TLS (juiceshop-full.json.tpl)
  #template = file("${path.module}/juiceshop-full.json.tftpl")

  vars = {
    app_tenant    = "ecommerce"
    app_name      = "juiceshop"
    app_address   = var.app-address
    app_node_port = "8000"

    #Part 1: Basic app (appBasic.json.tpl)
    app_node_ip = "10.1.20.2"

    #Part 2: App with Service Discovery and TLS (appServiceDiscoveryTLS.json.tpl)
    #app_tag         = "rsampaio-app"
    #app_region      = "southamerica-east1"
    #app_certificate = replace(tls_self_signed_cert.juiceshop-certificate.cert_pem, "/\n/", "\\n")
    #app_private_key = replace(tls_private_key.juiceshop-private-key.private_key_pem, "/\n/", "\\n")
  }
}

resource "bigip_as3" "juiceshop" {
  as3_json = data.template_file.juiceshop-declaration.rendered
}

