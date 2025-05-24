output "lambda_arn" {
  value = aws_lambda_function.convertr_lambda.invoke_arn
}

output "lambda_auth_arn" {
  value = aws_lambda_function.convertr_auth_lambda.invoke_arn
}
