output "auth_invoke_arn" {
  value = aws_lambda_function.auth_lambda.invoke_arn
}

output "invoke_arn" {
  value = aws_lambda_function.image_lambda.invoke_arn
}

output "name" {
  value = aws_lambda_function.image_lambda.function_name
}
