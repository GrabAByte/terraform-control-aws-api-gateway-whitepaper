resource "aws_api_gateway_rest_api" "convertr_api" {
  name               = var.api_name
  description        = "My ${var.api_name} API Gateway"
  binary_media_types = var.binary_media_types

  endpoint_configuration {
    types = var.endpoint_configuration_types
  }

  tags = var.tags
}

resource "aws_api_gateway_authorizer" "lambda_auth" {
  name                             = "LambdaTokenAuthorizer"
  rest_api_id                      = aws_api_gateway_rest_api.convertr_api.id
  authorizer_uri                   = var.lambda_auth_invoke_arn
  authorizer_result_ttl_in_seconds = 300
  type                             = "TOKEN"
  identity_source                  = "method.request.header.Authorization"
}

resource "aws_api_gateway_resource" "convertr_path" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id
  parent_id   = aws_api_gateway_rest_api.convertr_api.root_resource_id
  path_part   = var.api_path_part
}

resource "aws_api_gateway_method" "convertr_method" {
  rest_api_id   = aws_api_gateway_rest_api.convertr_api.id
  resource_id   = aws_api_gateway_resource.convertr_path.id
  http_method   = var.api_http_method
  authorization = var.api_authorization_method
  authorizer_id = aws_api_gateway_authorizer.lambda_auth.id
}

resource "aws_api_gateway_integration" "convertr_integration" {
  rest_api_id             = aws_api_gateway_rest_api.convertr_api.id
  resource_id             = aws_api_gateway_resource.convertr_path.id
  integration_http_method = var.integration_http_method
  http_method             = var.api_http_method
  type                    = var.integration_type
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "convertr_deployment" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id

  depends_on = [aws_api_gateway_integration.convertr_integration]
}

resource "aws_api_gateway_stage" "convertr_stage" {
  deployment_id = aws_api_gateway_deployment.convertr_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.convertr_api.id
  stage_name    = var.stage_name

  tags       = var.tags
  depends_on = [aws_api_gateway_deployment.convertr_deployment]
}
