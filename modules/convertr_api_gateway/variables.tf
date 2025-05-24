variable "api_name" {
  type        = string
  description = "The name of the API"
}

variable "lambda_auth_invoke_arn" {
  type = string
  description = "The Auth Lambda invocation ARN"
}

variable "api_authorization_method" {
  type        = string
  description = "The API Authroization Method"
}

variable "api_http_method" {
  type        = string
  description = "The API HTTP Method"
}

variable "api_path_part" {
  type        = string
  description = "The API path part"
}

variable "binary_media_types" {
  type        = list(any)
  description = "The applicable binary media types to accept"
  default = [
    "image/jpeg",
    "image/png"
  ]
}

variable "endpoint_configuration_types" {
  type = list(any)
  default = [
    "REGIONAL"
  ]
}

variable "integration_http_method" {
  type        = string
  description = "The Integration HTTP Method"
  default     = "GET"
}

variable "integration_type" {
  type        = string
  description = "The Integration platform provider"
  default     = "AWS_PROXY"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The URI to the Lambda integration"
}

variable "passthrough_behaviour" {
  type        = string
  description = "The passthrough behaviour for requests"
  default     = "WHEN_NO_MATCH"
}

variable "stage_name" {
  type        = string
  description = "The stage name for API resource"
}

variable "tags" {
  type        = map(any)
  description = "The project tags"
}
