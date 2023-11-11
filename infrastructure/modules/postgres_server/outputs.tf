output "postgres_public_ip" {
  value = aws_instance.postgres_server.public_ip
}

output "postgres_public_dns" {
  value = aws_instance.postgres_server.public_dns
}
