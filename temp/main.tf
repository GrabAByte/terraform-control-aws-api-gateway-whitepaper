module "convertr_vpc" {
  source = "./modules/convertr_vpc"

  cidr_block = "10.0.0.0/16"

  tags = local.tags
}

module "convertr_s3" {
  source = "./modules/convertr_s3"

  bucket_name = "convertr-bucket"

  tags = local.tags
}

module "convertr_lambda" {
  source = "./modules/convertr_lambda"

  bucket_arn                = module.convertr_s3.bucket_arn
  iam_role_name             = "convertr_lambda"
  archive_source            = "convertr_lambda.py"
  archive_output            = "convertr_lambda_function.zip"
  function_name             = "convertr_lambda_function"
  handler                   = "convertr_lambda.lambda_handler"
  runtime                   = "python3.9"
  api_gateway_execution_arn = module.convertr_api_gateway.api_gateway_execution_arn
  vpc_subnet                = module.convertr_vpc.subnet_id
  security_group            = module.convertr_vpc.security_group_id
  environment_variables = {
    bucket = module.convertr_s3.bucket_name
  }

  tags = local.tags
}

module "convertr_api_gateway" {
  source = "./modules/convertr_api_gateway"

  api_name                 = "convertr"
  api_path_part            = "upload"
  api_http_method          = "POST"
  api_authorization_method = "CUSTOM"
  integration_http_method  = "POST"
  integration_type         = "AWS_PROXY"
  lambda_invoke_arn        = module.convertr_lambda.lambda_arn
  lambda_auth_invoke_arn   = module.convertr_lambda.lambda_auth_arn
  stage_name               = "v1beta1"

  tags = local.tags
}
