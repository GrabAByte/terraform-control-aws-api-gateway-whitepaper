variable "vpc_endpoint_type" {
  type    = string
  default = "Gateway"
}

variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "tags" {
  type        = map(any)
  description = "The projects tags"
}

variable "subnet_cidr_block" {
  type        = string
  description = "The CIDR block range to allocate to the VPC"
  default     = "10.0.1.0/24"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block range to allocate to the VPC"
  default     = "10.0.0.0/16"
}
