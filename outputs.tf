output "app-url" {
  value = "http://${var.app-address}"
}

output "terraform-ip" {
  value = chomp(data.http.terraform-ip.response_body)
}
