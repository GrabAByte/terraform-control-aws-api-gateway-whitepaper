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
  http_method   = "PUT"
  authorization = var.api_authorization_method
}

resource "aws_api_gateway_method_response" "convertr_response" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id
  resource_id = aws_api_gateway_resource.convertr_path.id
  http_method = "PUT"
  status_code = 200
  response_models     = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "convertr_integration" {
  rest_api_id             = aws_api_gateway_rest_api.convertr_api.id
  resource_id             = aws_api_gateway_resource.convertr_path.id
  integration_http_method = var.integration_http_method
  http_method             = "PUT"
  passthrough_behavior    = var.passthrough_behaviour
  type                    = var.integration_type
  uri                     = var.lambda_invoke_arn
  request_templates       = {
    "application/pdf" = jsonencode({
      content = "$input.body"
    })
  }
}

resource "aws_api_gateway_integration_response" "convertr_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.convertr_api.id
  resource_id = aws_api_gateway_resource.convertr_path.id
  http_method = "PUT"
  status_code = aws_api_gateway_method_response.convertr_response.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = ""
  }
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
