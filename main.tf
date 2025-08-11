module "vpc" {
  source     = "github.com/GrabAByte/terraform-module-aws-vpc?ref=v1.2.1"
  nacl_rules = var.vpc_nacl_rules
}

module "s3" {
  source          = "github.com/GrabAByte/terraform-module-aws-s3?ref=v1.2.0"
  bucket_name     = "grababyte-api-gateway-whitepaper-bucket"
  log_bucket_name = "grababyte-api-gateway-whitepaper-log-bucket"

  tags = local.tags
}

module "dynamodb_upload" {
  source       = "github.com/GrabAByte/terraform-module-aws-dynamo-db?ref=v1.1.0"
  attributes   = var.dynamodb_attributes
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Timestamp"
  name         = "upload"
  range_key    = "Object"

  tags = local.tags
}

module "dynamodb_download" {
  source       = "github.com/GrabAByte/terraform-module-aws-dynamo-db?ref=v1.1.0"
  attributes   = var.dynamodb_attributes
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Timestamp"
  name         = "download"
  range_key    = "Object"

  tags = local.tags
}

module "lambda_auth" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.5.1"

  api_integration = true
  function_name   = "auth_function"
  handler         = "auth_function.lambda_handler"
  iam_role_name   = "auth_function_exec_role"
  lambda_source   = "auth_function.py"
  lambda_filename = "auth_function.zip"
  runtime         = "python3.13"

  security_groups = module.vpc.security_groups
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1

  tags = local.tags
}

module "lambda_upload" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.5.1"

  dynamodb_integration = true
  environment = {
    BUCKET = "grababyte-api-gateway-whitepaper-bucket"
    DDB    = "upload"
    STAGE  = local.environment
  }
  function_name   = "upload_function"
  handler         = "upload_function.lambda_handler"
  iam_role_name   = "upload_function_exec_role"
  lambda_source   = "upload_function.py"
  lambda_filename = "upload_function.zip"
  s3_integration  = true
  runtime         = "python3.13"

  bucket_arn         = module.s3.bucket_arn
  dynamodb_table_arn = module.dynamodb_upload.table_arn
  security_groups    = module.vpc.security_groups
  vpc_subnet_0       = module.vpc.vpc_subnet_0
  vpc_subnet_1       = module.vpc.vpc_subnet_1

  tags = local.tags
}

module "lambda_download" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.5.1"

  dynamodb_integration = true
  environment = {
    BUCKET = "grababyte-api-gateway-whitepaper-bucket"
    DDB    = "download"
    STAGE  = local.environment
  }
  function_name   = "download_function"
  handler         = "download_function.lambda_handler"
  iam_role_name   = "download_function_exec_role"
  lambda_source   = "download_function.py"
  lambda_filename = "download_function.zip"
  runtime         = "python3.13"
  s3_integration  = true

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
      http_method              = "GET"
      integration_http_method  = "POST"
      integration_type         = "AWS_PROXY"
      lambda_invoke_arn        = module.lambda_download.invoke_arn
    }
  }
  binary_media_types = [
    "application/octet-stream",
    "image/jpeg",
    "image/png"
  ]

  lambda_auth_invoke_arn = module.lambda_auth.invoke_arn
  lambda_names           = ["upload_function", "download_function"]
  stage_name             = "v1beta1"

  tags = local.tags
}
