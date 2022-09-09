output "app-url" {
  value = "http://${var.app-address}"
}

output "myip" {
  value = "${chomp(data.http.myip.response_body)}"
}