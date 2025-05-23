module "convertr_vpc" {
  source = "./modules/convertr_vpc"

  cidr_block = "10.0.0.0/16"

  tags = local.tags
}

module "convertr_s3" {
  source = "./modules/convertr_s3"

  bucket_name = "convertr-bucket"

  depends_on = [module.convertr_vpc]
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
  runtime                   = "python3.13"
  vpc_id                    = module.convertr_vpc.vpc_id
  environment_variables = {
    bucket = module.convertr_s3.bucket_name
  }

  depends_on = [module.convertr_s3]
  tags = local.tags
}

module "convertr_api_gateway" {
  source = "./modules/convertr_api_gateway"

  api_name                 = "convertr"
  api_path_part            = "upload"
  api_http_method          = "PUT"
  api_authorization_method = "NONE"
  integration_http_method  = "PUT"
  integration_type         = "AWS"
  lambda_invoke_arn        = module.convertr_lambda.lambda_arn
  stage_name               = "v1beta1"

  depends_on               = [module.convertr_lambda]
  tags = local.tags
}
