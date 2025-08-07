module "vpc" {
  source     = "github.com/GrabAByte/terraform-module-aws-vpc?ref=feat/extend"
  nacl_rules = var.nacl_rules
}

module "s3_auth" {
  source          = "github.com/GrabAByte/terraform-module-aws-s3?ref=v1.0.2"
  bucket_name     = "grababyte-auth-bucket"
  log_bucket_name = "grababyte-auth-log-bucket"

  tags = local.tags
}

module "s3_upload" {
  source          = "github.com/GrabAByte/terraform-module-aws-s3?ref=v1.0.2"
  bucket_name     = "grababyte-upload-bucket"
  log_bucket_name = "grababyte-upload-log-bucket"

  tags = local.tags
}

module "s3_download" {
  source          = "github.com/GrabAByte/terraform-module-aws-s3?ref=v1.0.2"
  bucket_name     = "grababyte-download-bucket"
  log_bucket_name = "grababyte-download-log-bucket"

  tags = local.tags
}

module "lambda_auth" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=feat/extend"

  function_name = "auth_lambda"
  handler       = "auth_function.lambda_handler"
  iam_role_name = "lambda_auth_exec_role"
  runtime       = "python3.13"
  lambda_source = "auth_function.py"

  bucket_name     = module.s3_auth.bucket_name
  bucket_arn      = module.s3_auth.bucket_arn
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "lambda_upload" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=feat/extend"

  function_name = "image_uploader"
  handler       = "lambda_function.lambda_handler"
  iam_role_name = "lambda_upload_exec_role"
  lambda_source = "upload_function.py"
  runtime       = "python3.13"

  bucket_name     = module.s3_upload.bucket_name
  bucket_arn      = module.s3_upload.bucket_arn
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "lambda-download" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=feat/extend"

  function_name = "image_downloader"
  handler       = "lambda_function.lambda_handler"
  # TODO: does this need to be set for all
  iam_role_name = "lambda_download_exec_role"
  # TODO: create real function
  lambda_source = "download_function.py"
  runtime       = "python3.13"

  bucket_name     = module.s3_download.bucket_name
  bucket_arn      = module.s3_download.bucket_arn
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "api_gateway" {
  source = "github.com/GrabAByte/terraform-module-aws-api-gateway?ref=feat/extend"

  api_name = "image"
  binary_media_types = [
    "image/jpeg",
    "image/png"
  ]

  # TODO: look up of auth lambda / output invoke_arn in module
  lambda_auth_invoke_arn = module.lambda_auth.invoke_arn

  api_routes = {
    "upload" = {
      http_method              = "POST"
      api_authorization_method = "CUSTOM"
      #    stage_name    = "v1beta1"
      #    lambda_invoke_arn      = module.lambda_upload.invoke_arn
      #    lambda_name            = module.lambda_upload.name
    },
    "download" = {
      api_authorization_method = "CUSTOM"
      http_method              = "POST"
      #    stage_name    = "v1beta1"
      #    lambda_auth_invoke_arn = module.lambda_download.auth_invoke_arn
      #    lambda_invoke_arn      = module.lambda_download.invoke_arn
      #    lambda_name            = module.lambda_download.name
    }
  }
  tags = local.tags
}
