module "datalake" {
  source = "./modules/datalake"
}

module "postgres_server" {
  source = "./modules/postgres_server"
}