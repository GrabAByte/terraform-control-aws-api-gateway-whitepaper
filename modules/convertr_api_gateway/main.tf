resource "aws_api_gateway_rest_api" "api" {
  name               = var.api_name
  binary_media_types = var.binary_media_types
}

resource "aws_api_gateway_resource" "upload" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.api_path_part
}

# authentication (time-bound implementation)
resource "aws_api_gateway_authorizer" "lambda_auth" {
  name                             = "LambdaTokenAuthorizer"
  rest_api_id                      = aws_api_gateway_rest_api.api.id
  authorizer_uri                   = var.lambda_auth_invoke_arn
  authorizer_result_ttl_in_seconds = 300
  type                             = "TOKEN"
  identity_source                  = "method.request.header.Authorization"
}

resource "aws_api_gateway_method" "upload_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.upload.id
  http_method   = var.api_http_method
  authorization = var.api_authorization_method
  authorizer_id = aws_api_gateway_authorizer.lambda_auth.id
}

resource "aws_api_gateway_integration" "upload_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.upload.id
  http_method             = aws_api_gateway_method.upload_post.http_method
  integration_http_method = var.integration_http_method
  type                    = var.integration_type
  uri                     = var.lambda_invoke_arn
}

resource "aws_lambda_permission" "upload_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGatewayUpload"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.upload_lambda]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name
  method_path = "${var.api_path_part}/POST"

  # observability
  # hardening: basic example of controlling number of requests
  settings {
    data_trace_eanbled     = true
    metrics_enabled        = true
    logging_level          = "ERROR"
    throttling_burst_limit = 10
    throttling_rate_limit  = 1
  }

  depends_on = [aws_api_gateway_deployment.deployment]
}
