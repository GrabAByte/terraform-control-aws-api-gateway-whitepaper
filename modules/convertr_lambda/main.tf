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
        Effect = "Allow"
        Resource = "arn:aws:s3:::image-uploader-bucket-demo/*"
      },
    ]
  })
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

  # vpc_config {
  #   subnet_ids         = [aws_subnet.subnet_private.id]
  #   security_group_ids = [aws_default_security_group.default_security_group.id]
  # }

  environment {
    variables = var.environment_variables
  }
}
