resource "aws_vpc" "convertr" {
  cidr_block = var.cidr_block

  tags = var.tags
}

resource "aws_subnet" "convertr_subnet" {
  vpc_id            = aws_vpc.convertr.id
  cidr_block        = "10.0.1.0/24"

  tags = var.tags
}

resource "aws_vpc_endpoint" "convertr_s3_endpoint" {
  vpc_id            = aws_vpc.convertr.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_vpc.convertr.main_route_table_id]
}

resource "aws_security_group" "convertr_security_group" {
  vpc_id = aws_vpc.convertr.id

  egress { # I: Security group rule does not have a description.
      description     = "Security Group for HTTPS access"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      prefix_list_ids = [aws_vpc_endpoint.convertr_s3_endpoint.prefix_list_id]
    }
  tags = var.tags
}

resource "aws_network_acl" "convertr_private_nacl" {
  vpc_id     = aws_vpc.convertr.id
  subnet_ids = [aws_subnet.convertr_subnet.id]

  egress {
    rule_no    = 100
    protocol   = "6"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    rule_no    = 110
    protocol   = "6"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    rule_no    = 100
    protocol   = "6"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    rule_no    = 110
    protocol   = "6"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Deny everything else
  ingress {
    rule_no    = 200
    protocol   = "-1"
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 200
    protocol   = "-1"
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
