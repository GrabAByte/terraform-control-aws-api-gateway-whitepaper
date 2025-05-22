variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "tags" {
  type        = map(any)
  description = "The tags associated to the cloud resource"
}
