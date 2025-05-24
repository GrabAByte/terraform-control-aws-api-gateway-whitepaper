output "subnet" {
  value = aws_subnet.private_subnet.id
}

output "sg" {
  value = aws_security_group.lambda_sg.id
}
