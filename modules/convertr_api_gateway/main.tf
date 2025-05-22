resource "aws_api_gateway_rest_api" "convertr_api" {
  name        = var.api_name
  description = "My ${var.api_name} API Gateway"

  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
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
}

# TODO: Fix Add operator for if to use resource
# resource "aws_api_gateway_integration" "convertr_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.convertr_api.id
#   resource_id             = aws_api_gateway_resource.convertr_path.id
#   integration_http_method = var.integration_http_method
#   http_method             = aws_api_gateway_method.convertr_method.http_method
#   type                    = var.integration_type
#   uri                     = var.lambda_invoke_arn
#}
