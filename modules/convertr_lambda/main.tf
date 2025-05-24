resource "aws_iam_role" "lambda_exec_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "convertr_lambda_s3_policy" {
  name = "convertr_lambda_s3_policy"
  role = aws_iam_role.lambda_exec_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "${var.bucket_arn}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_exec" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "image_lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.lambda_filename

  vpc_config {
    subnet_ids         = [var.subnet]
    security_group_ids = [var.sg]
  }

  environment {
    variables = {
      BUCKET = var.bucket_name
    }
  }
}

resource "aws_lambda_function" "auth_lambda" {
  function_name = var.auth_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.auth_handler
  runtime       = var.auth_runtime
  filename      = var.auth_lambda_filename
}

resource "aws_lambda_permission" "auth_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGatewayAuth"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.auth_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
