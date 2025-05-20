variable "api_name" {
  type        = string
  description = "The name of the API"
}

variable "endpoint_configuration_types" {
  type    = List
  default = [
    "REGIONAL"
  ]
}

variable "api_path_part" {
  type        = string
  description = "The API path part"
}

variable "api_http_method" {
  type        = string
  description = "The API HTTP Method"
}

variable "api_authorization_mathod" {
  type        = string
  description = "The API Authroization Method"
}

variable "integration_http_method" {
  type        = string
  description = "The Integration HTTP Method"
  default     = "GET"
}

variable "integration_type" {
  type        = string
  description = "The Integration platform provider"
}
