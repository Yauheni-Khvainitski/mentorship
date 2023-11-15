output "rds_pg_airflow_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.airflow_backend.address
  sensitive   = true
}

output "rds_pg_airflow_port" {
  description = "RDS instance port"
  value       = aws_db_instance.airflow_backend.port
  sensitive   = true
}

output "rds_pg_airflow_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.airflow_backend.username
  sensitive   = true
}