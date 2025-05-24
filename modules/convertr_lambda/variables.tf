variable "region" {
  type = string
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
