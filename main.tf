module "convertr_api_gateway" {
  source = "./modules/convertr_api_gateway"

  api_name                 = "convertr"
  api_path_part            = "convertr"
  api_http_method          = "PUT"
  api_authorization_method = "NONE"
  integration_http_method  = "POST"
  integration_type         = "AWS"
  lambda_invoke_arn        = module.convertr_lambda.lambda_arn
}

module "convertr_lambda" {
  source = "./modules/convertr_lambda"

  iam_role_name  = "convertr_lambda"
  archive_source = "convertr_lambda.py"
  archive_output = "convertr_lambda_function.zip"
  function_name  = "convertr_lambda_function"
  handler        = "index.handler"
  runtime        = "python3.13"
  environment_variables = {
    bucket = "convertr-bucket"
  }
}

module "convertr_s3" {
  source = "./modules/convertr_s3"

  bucket_name = "convertr-bucket"
  tags        = merge(local.tags, { project = "convertr-demo" })
}

module "convertr_vpc" {
  source = "./modules/convertr_vpc"

  cidr_block = "10.0.0.0/16"
}
