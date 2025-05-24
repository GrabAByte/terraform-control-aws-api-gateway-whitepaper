variable "auth_function_name" {
  type        = string
  description = "The Lambda function name"
}

variable "auth_handler" {
  type        = string
  description = "The lambda handler"
}

variable "auth_runtime" {
  type        = string
  description = "The lambda runtime"
}

variable "auth_lambda_filename" {
  type        = string
  description = "The lambda filename"
}

variable "bucket_arn" {
  type        = string
  description = "The S3 bucket ARN to upload to"
}

variable "bucket_name" {
  type        = string
  description = "The S3 bucket to upload to"
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

variable "lambda_filename" {
  type        = string
  description = "The lambda filename"
  default     = "lambda_function.zip"
}

variable "region" {
  type        = string
  description = "The AWS region in which to deploy"
  default     = "eu-west-2"
}

variable "runtime" {
  type        = string
  description = "The lambda runtime"
}

variable "security_groups" {
  type        = string
  description = "The security group(s) to attach the lambda to"
}

variable "tags" {
  type        = map(any)
  description = "The project tags"
}

variable "vpc_subnets" {
  type        = string
  description = "The VPC subnet(s) to deploy the lambda into"
}
