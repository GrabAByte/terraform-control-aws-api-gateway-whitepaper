data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_vpc" "convertr" {
  cidr_block = var.cidr_block

  tags = var.tags
}

resource "aws_default_security_group" "convertr_security_group" {
  vpc_id = aws_vpc.convertr.id

  tags = var.tags
}

resource "aws_subnet" "convertr_subnet" {
  count             = 2
  vpc_id            = aws_vpc.convertr.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = var.tags
}
