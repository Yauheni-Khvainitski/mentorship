output "rds_pg_airflow_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.airflow_backend.address
}

output "rds_pg_airflow_port" {
  description = "RDS instance port"
  value       = aws_db_instance.airflow_backend.port
}

output "rds_pg_airflow_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.airflow_backend.username
}