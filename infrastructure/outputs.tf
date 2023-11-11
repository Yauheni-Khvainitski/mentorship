output "app_server_public_ip" {
  value = module.app_server.public_ip
}

output "app_server_public_dns" {
  value = module.app_server.public_dns
}
