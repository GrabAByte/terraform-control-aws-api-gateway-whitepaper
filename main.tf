module "vpc" {
  source = "./modules/convertr_vpc"

  # tags = local.tags
}

module "s3" {
  source      = "./modules/convertr_s3"
  bucket_name = "convertr-upload-bucket"

  tags        = local.tags
}

module "lambda" {
  source = "./modules/convertr_lambda"

  bucket_name = module.s3.bucket_name
  subnet      = module.vpc.subnet
  sg          = module.vpc.sg

  # tags = local.tags
}

module "api_gateway" {
  source = "./modules/convertr_api_gateway"

  lambda_auth_invoke_arn = module.lambda.auth_invoke_arn
  lambda_invoke_arn      = module.lambda.invoke_arn
  lambda_name            = module.lambda.name

  # tags = local.tags
}
