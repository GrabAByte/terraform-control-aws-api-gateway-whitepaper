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
  name               = "convertr_lambda_role" # var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.convertr_lambda_policy.json
}

data "archive_file" "convertr_lambda_archive" {
  type        = "zip"                            # var.archive_type
  source_file = "convertr_lambda.py"             # var.archive_source
  output_path = "convertr_lambda_function.zip"   # var.archive_output
}

resource "aws_lambda_function" "convertr_lambda" {
  filename      = "convertr_lambda_function.zip" # var.function_filename
  function_name = "convertr_lambda_function"     # var.function_name
  role          = aws_iam_role.convertr_lambda_role.arn
  handler       = "index.handler"                # var.handler
  runtime = "python3.13"                         # var.runtime
  source_code_hash = data.archive_file.convertr_lambda_archive.output_base64sha256

  # vpc_config {
  #   subnet_ids         = [aws_subnet.subnet_private.id]
  #   security_group_ids = [aws_default_security_group.default_security_group.id]
  # }

  environment {   # var.environment_variables
    variables = {
      foo = "bar"
    }
  }
}
