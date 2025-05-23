variable "aws_region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "archive_output" {
  type        = string
  description = "The output archive file nme"
}

variable "archive_source" {
  type        = string
  description = "The source file for the lambda function"
}

variable "archive_type" {
  type        = string
  description = "The type of archive to use for the lambda function"
  default     = "zip"
}

variable "bucket_arn" {
  type        = string
  description = "The S3 bucket ARN to upload the images to"
}

variable "bucket_object" {
  type        = string
  description = "The S3 bucket object(s)"
  default     = "*"
}

variable "environment_variables" {
  type        = map(any)
  description = "The Environment variables available to the lambda function"
}

variable "function_name" {
  type        = string
  description = "The Lambda function name"
}

variable "handler" {
  type        = string
  description = "The lambda handler"
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM Role to assign the policy to"
}

variable "runtime" {
  type        = string
  description = "The lambda runtime"
}

variable "tags" {
  type        = map(any)
  description = "The project tags"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to create an endpoint from"
}

variable "vpc_type" {
  type        = string
  description = "The type of VPC endpoint [gateway,interface]"
  default     = "Interface"
}

variable "vpc_subnets" {
  type = list
  description = "The VPC subnets to place the service within"
}

variable "security_groups" {
  type = list
  description = "The security groups to places the services within"
}
