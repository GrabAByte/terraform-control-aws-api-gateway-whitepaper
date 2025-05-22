resource "aws_api_gateway_rest_api" "convertr_api" {
  name               = var.api_name
  description        = "My ${var.api_name} API Gateway"
  binary_media_types = var.binary_media_types

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

resource "aws_api_gateway_integration" "convertr_integration" {
  rest_api_id             = aws_api_gateway_rest_api.convertr_api.id
  resource_id             = aws_api_gateway_resource.convertr_path.id
  integration_http_method = var.integration_http_method
  http_method             = aws_api_gateway_method.convertr_method.http_method
  passthrough_behavior    = var.passthrough_behaviour
  content_handling        = var.content_handling
  type                    = var.integration_type
  uri                     = var.lambda_invoke_arn
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

resource "aws_api_gateway_deployment" "convertr_deployment" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.convertr_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [time_sleep.wait_30_seconds]

}

resource "aws_api_gateway_stage" "convertr_stage" {
  deployment_id = aws_api_gateway_deployment.convertr_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.convertr_api.id
  stage_name    = "demo"

  depends_on = [aws_api_gateway_deployment.convertr_deployment]
}
