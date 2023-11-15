module "datalake" {
  source = "./modules/datalake"
}

module "postgres_server" {
  source = "./modules/postgres_server"
}

module "rds_pg_airflow_backend" {
  source = "./modules/rds_pg_airflow_backend"
  airflow_password  = var.airflow_password
  airflow_user_name = var.airflow_user_name
}
