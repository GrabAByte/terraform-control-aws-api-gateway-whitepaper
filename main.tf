module "vpc" {
  source = "./modules/convertr_vpc"

  tags = local.tags
}

module "s3" {
  source      = "./modules/convertr_s3"
  bucket_name = "convertr-upload-bucket"

  tags = local.tags
}

module "lambda" {
  source = "./modules/convertr_lambda"

  auth_function_name   = "auth_lambda"
  auth_handler         = "auth_function.lambda_handler"
  auth_runtime         = "python3.13"
  auth_lambda_filename = "auth_function.zip"
  function_name        = "image_uploader"
  handler              = "lambda_function.lambda_handler"
  iam_role_name        = "lambda_exec_role"
  runtime              = "python3.13"

  bucket_name     = module.s3.bucket_name
  bucket_arn      = module.s3.bucket_arn
  vpc_subnets     = module.vpc.vpc_subnets
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "api_gateway" {
  source = "./modules/convertr_api_gateway"

  api_name      = "converter_api"
  api_path_part = "upload"
  stage_name    = "v1beta1"
  binary_media_types = [
    "image/jpeg",
    "image/png"
  ]
  lambda_auth_invoke_arn = module.lambda.auth_invoke_arn
  lambda_invoke_arn      = module.lambda.invoke_arn
  lambda_name            = module.lambda.name

  tags = local.tags
}
