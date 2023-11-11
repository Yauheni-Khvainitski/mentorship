module "datalake" {
  source = "./modules/datalake"
}

# TODO: Will be changed to other data services
module "app_server" {
  source = "./modules/app_server"
}