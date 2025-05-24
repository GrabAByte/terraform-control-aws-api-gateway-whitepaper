resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "vpc_exec" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "image_lambda" {
  function_name = "image_uploader"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "lambda_function_payload.zip"

  vpc_config {
    subnet_ids         = [var.subnet] # vpc subnet output
    security_group_ids = [var.sg]     # vpc sg output
  }

  environment {
    variables = {
      BUCKET = var.bucket_name # s3 ouput
    }
  }
}

resource "aws_lambda_function" "auth_lambda" {
  function_name = "auth_lambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "auth_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "auth_function_payload.zip"
}

resource "aws_lambda_permission" "auth_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGatewayAuth"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.auth_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
