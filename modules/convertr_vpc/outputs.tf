output "vpc_subnets" {
  value = aws_subnet.private_subnet.id
}

output "security_groups" {
  value = aws_security_group.lambda_sg.id
}
