variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "subnet" {
  type = string
}

variable "sg" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_arn" {
  type = string
}

variable "function_name" {
  type        = string
  description = "The Lambda function name"
  default     = "image_uploader"
}

variable "handler" {
  type        = string
  description = "The lambda handler"
  default     = "lambda_function.lambda_handler"
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM Role to assign the policy to"
  default     = "lambda_exec_role"
}

variable "runtime" {
  type        = string
  description = "The lambda runtime"
  default     = "python3.9"
}

variable "lambda_filename" {
  type        = string
  description = "The lambda filename"
  default     = "lambda_function.zip"
}

variable "tags" {
  type        = map(any)
  description = "The project tags"
}

variable "auth_function_name" {
  type        = string
  description = "The Lambda function name"
  default     = "auth_lambda"
}

variable "auth_handler" {
  type        = string
  description = "The lambda handler"
  default     = "auth_function.lambda_handler"
}

variable "auth_runtime" {
  type        = string
  description = "The lambda runtime"
  default     = "python3.9"
}

variable "auth_lambda_filename" {
  type        = string
  description = "The lambda filename"
  default     = "auth_function.zip"
}
