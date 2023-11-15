output "app_server_public_ip" {
  value = module.postgres_server.postgres_public_ip
}

output "app_server_public_dns" {
  value = module.postgres_server.postgres_public_dns
}

output "rds_pg_airflow_host" {
  value = module.rds_pg_airflow_backend.rds_pg_airflow_hostname
}

output "rds_pg_airflow_port" {
  value = module.rds_pg_airflow_backend.rds_pg_airflow_port
}

output "rds_pg_airflow_username" {
  value = module.rds_pg_airflow_backend.rds_pg_airflow_username
}
