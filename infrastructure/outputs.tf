output "app_server_public_ip" {
  value = module.postgres_server.postgres_public_ip
}

output "app_server_public_dns" {
  value = module.postgres_server.postgres_public_dns
}
