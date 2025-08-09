module "vpc" {
  source     = "github.com/GrabAByte/terraform-module-aws-vpc?ref=v1.2.1"
  nacl_rules = var.nacl_rules
}

module "s3" {
  source          = "github.com/GrabAByte/terraform-module-aws-s3?ref=v1.2.0"
  bucket_name     = "grababyte-api-whitepaper-bucket"
  log_bucket_name = "grababyte-api-whitepaper-log-bucket"

  tags = local.tags
}

module "dynamodb_upload" {
  source       = "github.com/GrabAByte/terraform-module-aws-dynamo-db?ref=v1.1.0"
  attributes   = var.attributes
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Timestamp"
  name         = "upload"
  range_key    = "Object"

  tags = local.tags
}

module "dynamodb_download" {
  source       = "github.com/GrabAByte/terraform-module-aws-dynamo-db?ref=v1.1.0"
  attributes   = var.attributes
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Timestamp"
  name         = "download"
  range_key    = "Object"

  tags = local.tags
}

module "lambda_auth" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.4.0"

  api_integration = true
  function_name   = "auth_lambda"
  handler         = "auth_function.lambda_handler"
  iam_role_name   = "lambda_auth_exec_role"
  lambda_source   = "auth_function.py"
  lambda_filename = "auth_function.zip"
  runtime         = "python3.13"

  security_groups = module.vpc.security_groups
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1

  tags = local.tags
}

module "lambda_upload" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.4.0"

  dynamodb_integration = true
  function_name        = "image_uploader"
  handler              = "upload_function.lambda_handler"
  iam_role_name        = "lambda_upload_exec_role"
  lambda_source        = "upload_function.py"
  lambda_filename      = "upload_function.zip"
  s3_integration       = true
  runtime              = "python3.13"

  bucket_arn         = module.s3.bucket_arn
  dynamodb_table_arn = module.dynamodb_upload.table_arn
  security_groups    = module.vpc.security_groups
  vpc_subnet_0       = module.vpc.vpc_subnet_0
  vpc_subnet_1       = module.vpc.vpc_subnet_1

  tags = local.tags
}

module "lambda_download" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.4.0"

  dynamodb_integration = true
  function_name        = "image_downloader"
  handler              = "doownload_function.lambda_handler"
  iam_role_name        = "lambda_download_exec_role"
  lambda_source        = "download_function.py"
  lambda_filename      = "download_function.zip"
  runtime              = "python3.13"
  s3_integration       = true

  bucket_arn         = module.s3.bucket_arn
  dynamodb_table_arn = module.dynamodb_download.table_arn
  security_groups    = module.vpc.security_groups
  vpc_subnet_0       = module.vpc.vpc_subnet_0
  vpc_subnet_1       = module.vpc.vpc_subnet_1

  tags = local.tags
}

module "api_gateway" {
  source = "github.com/GrabAByte/terraform-module-aws-api-gateway?ref=v1.2.1"

  api_name = "image"
  api_routes = {
    "upload" = {
      api_authorization_method = "CUSTOM"
      http_method              = "POST"
      integration_http_method  = "POST"
      integration_type         = "AWS_PROXY"
      lambda_invoke_arn        = module.lambda_upload.invoke_arn
    },
    "download" = {
      api_authorization_method = "CUSTOM"
      http_method              = "POST"
      integration_http_method  = "POST"
      integration_type         = "AWS_PROXY"
      lambda_invoke_arn        = module.lambda_download.invoke_arn
    }
  }
  binary_media_types = [
    "image/jpeg",
    "image/png"
  ]

  lambda_auth_invoke_arn = module.lambda_auth.invoke_arn
  lambda_names           = ["image_uploader", "image_downloader"]
  stage_name             = "v1beta1"

  tags = local.tags
}
