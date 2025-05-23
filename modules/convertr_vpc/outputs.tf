output "vpc_id" {
  value = aws_vpc.convertr.id
}

output "subnet_ids" {
  value = aws_subnet.aws_subnet[*].id
}

output "security_groups" {
  value = aws_default_security_group.convertr_security_group
}
