module "vpc" {
  source = "github.com/GrabAByte/terraform-module-aws-vpc?ref=v1.0.0"
}

module "s3" {
  source      = "github.com/GrabAByte/terraform-module-aws-s3?ref=1.0.2"
  bucket_name = "convertr-upload-bucket"

  tags = local.tags
}

module "lambda" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=1.0.1"

  auth_function_name   = "auth_lambda"
  auth_handler         = "auth_function.lambda_handler"
  auth_runtime         = "python3.13"
  auth_lambda_source   = "auth_function.py"
  auth_lambda_filename = "auth_function.zip"
  function_name        = "image_uploader"
  handler              = "lambda_function.lambda_handler"
  iam_role_name        = "lambda_exec_role"
  lambda_source        = "lambda_function.py"
  runtime              = "python3.13"

  bucket_name     = module.s3.bucket_name
  bucket_arn      = module.s3.bucket_arn
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "api_gateway" {
  source = "github.com/GrabAByte/terraform-module-aws-api-gateway?ref=1.0.2"

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
