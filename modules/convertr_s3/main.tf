data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "image_bucket" {
  bucket        = var.bucket_name
  force_destroy = false
  tags          = var.tags
}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = var.log_bucket_name
  force_destroy = false
  tags          = var.tags
}

resource "aws_s3_bucket_ownership_controls" "image_bucket" {
  bucket = aws_s3_bucket.image_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_ownership_controls" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# monitoring
resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.image_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "/"
}

# retention
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.image_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# housekeeping
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.image_bucket.id

  rule {
    id     = "delete_old_versions"
    status = "Enabled"
    filter {
      prefix = "/"
    }

    noncurrent_version_expiration {
      noncurrent_days = var.bucket_version_expiry
    }
  }

  rule {
    id     = "abort_incomplete_uploads"
    status = "Enabled"
    filter {
      prefix = "/"
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = var.bucket_incomplete_expiry
    }
  }

  rule {
    id     = "expire_delete_markers"
    status = "Enabled"
    filter {
      prefix = "/"
    }

    expiration {
      expired_object_delete_marker = var.bucket_delete_markers
    }
  }
}

# encryption
resource "aws_kms_key" "s3_encryption_key" {
  description             = "KMS key for S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "s3-kms-policy",
    Statement : [
      {
        Sid : "AllowS3UseOfTheKey",
        Effect : "Allow",
        Principal : {
          Service : "s3.amazonaws.com"
        },
        Action : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*"
        ],
        Resource : "*",
        Condition : {
          StringEquals : {
            "kms:ViaService" : "s3.${var.region}.amazonaws.com"
          }
        }
      },
      {
        Sid : "AllowAdminAccess",
        Effect : "Allow",
        Principal : {
          AWS : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action : "kms:*",
        Resource : "*"
      }
    ]
  })
}

resource "aws_kms_key" "key" {
  description             = "KMS Key for SSE-KMS"
  enable_key_rotation     = var.kms_enable_rotation
  deletion_window_in_days = var.kms_deletion_window_days

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.image_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = var.kms_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_logs" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = var.kms_sse_algorithm
    }
  }
}

# network access
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.image_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "block_public_logs" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# encrypted traffic
resource "aws_s3_bucket_policy" "https_only" {
  bucket = aws_s3_bucket.image_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceHTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.image_bucket.arn}/*",
          aws_s3_bucket.image_bucket.arn
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" : "false"
          }
        }
      }
    ]
  })
}
