module "convertr_api_gateway" {
  source = "./modules/convertr_api_gateway"

  # vars
}

module "convertr_lambda" {
  source = "./modules/convertr_lambda"

  # vars
}

module "convertr_s3" {
  source = "./modules/convertr_s3"

  # vars
}

module "convertr_vpc" {
  source = "./modules/convertr_vpc"

  # vars
}
