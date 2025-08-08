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
    project     = "api-lambda-trigger-to-s3"
  }
}

variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "nacl_rules" {
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

variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "List of DynamoDB table attributes"
}

variable "ttl" {
  type = list(object({
    attribute_name = string
    enabled        = bool
  }))
  description = "TTL attributes"
}

variable "gsi" {
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = optional(string)
    projection_type    = string
    non_key_attributes = optional(list(string))
    #read_capacity      = optional(number)
    #write_capacity     = optional(number)
  }))
  description = "List of global secondary indexes for the DynamoDB table"
}
