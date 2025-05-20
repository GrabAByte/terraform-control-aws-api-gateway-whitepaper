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
  name               = "convertr_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.convertr_lambda_policy.json
}

data "archive_file" "convertr_lambda_archive" {
  type        = "zip"
  source_file = "convertr_lambda.py"
  output_path = "convertr_lambda_function.zip"
}

resource "aws_lambda_function" "convertr_lambda" {
  filename      = "convertr_lambda_function.zip"
  function_name = "convertr_lambda_function"
  role          = aws_iam_role.convertr_lambda_role.arn
  handler       = "index.test"
  runtime = "python3.13"
  source_code_hash = data.archive_file.convertr_lambda_archive.output_base64sha256

  # vpc_config {
  #   subnet_ids         = [aws_subnet.subnet_private.id]
  #   security_group_ids = [aws_default_security_group.default_security_group.id]
  # }

  environment {
    variables = {
      foo = "bar"
    }
  }
}
