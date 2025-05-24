data "aws_iam_policy_document" "convertr_lambda_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "convertr_lambda_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.convertr_lambda_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy" "convertr_lambda_s3_policy" {
  name = "convertr_lambda_s3_policy"
  role = aws_iam_role.convertr_lambda_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "${var.bucket_arn}/${var.bucket_object}"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "convertr_vpc_exec" {
  role       = aws_iam_role.convertr_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "archive_file" "convertr_lambda_archive" {
  type        = var.archive_type
  source_file = var.archive_source
  output_path = var.archive_output
}

resource "aws_lambda_function" "convertr_lambda" {
  filename         = var.archive_output
  function_name    = var.function_name
  role             = aws_iam_role.convertr_lambda_role.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = data.archive_file.convertr_lambda_archive.output_base64sha256

  vpc_config {
    subnet_ids         = [var.vpc_subnet]
    security_group_ids = [var.security_group]
  }

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_lambda_function" "convertr_auth_lambda" { # I: Function does not have tracing enabled.
  function_name = "converter_auth_lambda"
  role          = aws_iam_role.convertr_lambda_role.arn
  handler       = "convertr_auth_lambda.lambda_handler"
  runtime       = var.runtime
  filename      = "convertr_auth_lambda.zip"
}

resource "aws_lambda_permission" "auth_api_gateway" { # E: Lambda permission lacks source ARN for *.amazonaws.com principal.
  statement_id  = "AllowExecutionFromAPIGatewayAuth"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.convertr_auth_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.convertr_lambda_role.name
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.convertr_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}
