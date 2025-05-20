resource "aws_api_gateway_rest_api" "convertr_api" {
  name = "convertr_api"
  description = "My convertr API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "convertr_path" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id
  parent_id   = aws_api_gateway_rest_api.convertr_api.root_resource_id
  path_part   = "convertr"
}

resource "aws_api_gateway_method" "convertr_method" {
  rest_api_id   = aws_api_gateway_rest_api.convertr_api.id
  resource_id   = aws_api_gateway_resource.convertr_path.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "convertr_integration" {
  rest_api_id             = aws_api_gateway_rest_api.convertr_api.id
  resource_id             = aws_api_gateway_resource.convertr_path.id
  integration_http_method = "POST"
  http_method             = aws_api_gateway_method.convertr_method.http_method
  type                    = "AWS"
  uri                     = aws_lambda_function.convertr_lambda.invoke_arn
}
