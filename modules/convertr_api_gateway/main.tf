resource "aws_api_gateway_rest_api" "api" {
  name = "ImageUploadAPI"
  binary_media_types = [
    "image/jpeg",
    "image/png"
  ]
}

resource "aws_api_gateway_resource" "upload" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "upload"
}

# Lambda Authorizer
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
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_auth.id
}

resource "aws_api_gateway_integration" "upload_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.upload.id
  http_method             = aws_api_gateway_method.upload_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
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
  stage_name  = "v1beta1"
}

# diff
# usingg deployment and stage resource separately
