output "vpc_id" {
  value = aws_vpc.convertr.id
}

output "subnet_id" {
  value = aws_subnet.convertr_subnet.id
}

output "security_group_id" {
  value = aws_security_group.convertr_security_group.id
}
