module "vpc" {
  source = "github.com/GrabAByte/terraform-module-aws-vpc?ref=v1.0.0"
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

module "lambda_upload" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.0.1"

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

  bucket_name     = module.s3_upload.bucket_name
  bucket_arn      = module.s3_upload.bucket_arn
  vpc_subnet_0    = module.vpc.vpc_subnet_0
  vpc_subnet_1    = module.vpc.vpc_subnet_1
  security_groups = module.vpc.security_groups

  tags = local.tags
}

module "lambda-download" {
  source = "github.com/GrabAByte/terraform-module-aws-lambda?ref=v1.0.1"

  auth_function_name   = "auth_lambda"
  auth_handler         = "auth_function.lambda_handler"
  auth_runtime         = "python3.13"
  auth_lambda_source   = "auth_function.py"
  auth_lambda_filename = "auth_function.zip"
  function_name        = "image_downloader"
  handler              = "lambda_function.lambda_handler"
  iam_role_name        = "lambda_exec_role"
  lambda_source        = "lambda_function.py"
  runtime              = "python3.13"

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
  #api_routes = {
  #  "upload" = {
  #    api_path_part = "upload"
  #    stage_name    = "v1beta1"
  #    http_method   = "POST"
  #   binary_media_types = [
  #      "image/jpeg",
  #      "image/png"
  #    ]
  #    lambda_auth_invoke_arn = module.lambda_upload.auth_invoke_arn
  #    lambda_invoke_arn      = module.lambda_upload.invoke_arn
  #    lambda_name            = module.lambda_upload.name
  #  },
  #  "download" = {
  #    api_path_part = "download"
  #    stage_name    = "v1beta1"
  #    binary_media_types = [
  #      "image/jpeg",
  #      "image/png"
  #    ]
  #    lambda_auth_invoke_arn = module.lambda_download.auth_invoke_arn
  #    lambda_invoke_arn      = module.lambda_download.invoke_arn
  #    lambda_name            = module.lambda_download.name
  #  }
  #}
  tags = local.tags
}
