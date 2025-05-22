variable "api_gateway_execution_arn" {
  type = string
  description = "The Execution AEN of the API Gateway"
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
