variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block range to allocate to the VPC"
  default     = "10.0.0.0/16"
}

variable "tags" {
  type        = map(any)
  description = "The projects tags"
  default = {
    project = "convertr-demo"
  }
}
