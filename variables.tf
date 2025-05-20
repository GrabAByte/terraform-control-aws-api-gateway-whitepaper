variable "environment_map" {
  type        = map(any)
  description = "The environment lookup for each workspace"
  default = {
    development    = "development"
    pre-production = "pre-production"
    production     = "production"
  }
}

variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

/*
variable "" {
  type        = map(any)
  description = ""
  default = {
    development    = "??-dev"
    pre-production = "??-pre-production"
    production     = "??-production"
  }
}
*/

locals {
  environment = lookup(var.environment_map, terraform.workspace, "development")
  tags = {
    environment = local.environment
  }
}
