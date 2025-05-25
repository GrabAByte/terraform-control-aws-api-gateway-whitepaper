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

# least privilege iam
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

# using latest runtime: python3.13
resource "aws_lambda_function" "image_lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.lambda_filename

  # observability options
  logging_config {
    log_format       = "JSON"
    system_log_level = "DEBUG"
  }

  tracing_config {
    mode = "Active"
  }

  # higher availability over multiple availability zones
  # port restriction through security group
  vpc_config {
    subnet_ids         = [var.vpc_subnet_0, var.vpc_subnet_1]
    security_group_ids = [var.security_groups]
  }

  environment {
    variables = {
      BUCKET = var.bucket_name
    }
  }
}

# using latest runtime: python3.13
resource "aws_lambda_function" "auth_lambda" {
  function_name = var.auth_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.auth_handler
  runtime       = var.auth_runtime
  filename      = var.auth_lambda_filename

  # observability options
  logging_config {
    log_format       = "JSON"
    system_log_level = "DEBUG"
  }

  tracing_config {
    mode = "Active"
  }

  # higher availability over multiple availability zones
  # port restriction through security group
  vpc_config {
    subnet_ids         = [var.vpc_subnet_0, var.vpc_subnet_1]
    security_group_ids = [var.security_groups]
  }

  # TODO: Retrieve $TOKEN AWS secret for Auth Lambda to determine if Bearer Token is accurate
  environment {
    variables = {
      TOKEN = "convertr_api_token"
    }
  }
}

resource "aws_lambda_permission" "auth_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGatewayAuth"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.auth_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
