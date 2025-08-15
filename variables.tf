variable "environment_map" {
  type        = map(any)
  description = "The environment lookup for each workspace"
  default = {
    development    = "development"
    pre-production = "pre-production"
    production     = "production"
  }
}

locals {
  environment = lookup(var.environment_map, terraform.workspace, "development")
  tags = {
    environment = local.environment
    project     = "api-gateway-whitepaper"
  }
}

variable "dynamodb_billing_mode" {
  type        = string
  description = "The DynamoDB Billing Mode"
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "List of DynamoDB table attributes"
}

variable "s3_enable_encryption" {
  type        = bool
  description = "Enable KMS encryption of S3 buckets"
}

variable "vpc_nacl_rules" {
  description = "List of ingress and egress NACL rules"
  type = list(object({
    rule_number = number
    protocol    = string
    rule_action = string
    egress      = bool
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "lambda_runtime" {
  type        = string
  description = "The Lambda runtime"
  default     = "python3.13"
}

variable "api_stage_name" {
  type        = string
  description = "The stage name of the API Gateway"
  default     = "v1beta1"
}