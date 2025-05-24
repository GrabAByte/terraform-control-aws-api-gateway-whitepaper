variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "bucket_delete_markers" {
  type        = bool
  description = "whether to expire delete markers"
  default     = true
}

variable "bucket_incomplete_expiry" {
  type        = number
  description = "number of days before deleting incomplete uploads"
  default     = 7
}

variable "bucket_version_expiry" {
  type        = number
  description = "number of days before deleting old versions"
  default     = 90
}

variable "kms_enable_rotation" {
  type        = bool
  description = "whether to expire delete markers"
  default     = true
}

variable "kms_deletion_window_days" {
  type        = number
  description = "number of days until deletion of KMS key"
  default     = 20
}

variable "kms_sse_algorithm" {
  type        = string
  description = "the algorithm to encrpyt with"
  default     = "aws:kms"
}

variable "log_bucket_name" {
  type        = string
  description = "The bucket log events within"
  default     = "convertr-log-bucket"
}

variable "tags" {
  type        = map(any)
  description = "The project tags"
}
