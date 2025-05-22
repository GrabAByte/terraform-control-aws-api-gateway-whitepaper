variable "iam_role_name" {
  type        = string
  description = "The name of the IAM Role to assign the policy to"
}

variable "archive_type" {
  type        = string
  description = "The type of archive to use for the lambda function"
  default     = "zip"
}

variable "archive_source" {
  type        = string
  description = "The source file for the lambda function"
}

variable "archive_output" {
  type        = string
  description = "The output archive file nme"
}

variable "function_name" {
  type        = string
  description = "The Lambda function name"
}

variable "handler" {
  type        = string
  description = "The lambda handler"
}

variable "runtime" {
  type        = string
  description = "The lambda runtime"
}

variable "environment_variables" {
  type        = map(any)
  description = "The Environment variables available to the lambda function"
}
