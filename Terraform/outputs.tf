output "server_ip" {
  value = aws_instance.server.public_ip
}

output "grafana_url" {
  value = "http://${aws_instance.server.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${aws_instance.server.public_ip}:9090"
}