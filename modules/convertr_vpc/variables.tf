variable "cidr_block" {
  type        = string
  description = "The CIDR block range to allocate to the VPC"
  default     = "10.0.0.0/16"
}
