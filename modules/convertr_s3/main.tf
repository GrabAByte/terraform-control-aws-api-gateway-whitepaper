data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "convertr" {
  bucket = var.bucket_name
  # for terraforms sake
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "convertr_versioning" {
  bucket = aws_s3_bucket.convertr.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "convertr_lifecycle" {
  bucket = aws_s3_bucket.convertr.id

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

resource "aws_kms_key_policy" "convert_key_policy" {
  key_id = aws_kms_key.convertr_key.id
  policy = jsonencode({
    Id = "key"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/grababyte"
        }
        Action = [
          "kms:ReplicateKey",
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ]
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_kms_key" "convertr_key" {
  description             = "KMS Key for SSE-KMS"
  enable_key_rotation     = var.kms_enable_rotation
  deletion_window_in_days = var.kms_deletion_window_days

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "convertr_encrypt" {
  bucket = aws_s3_bucket.convertr.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.convertr_key.arn
      sse_algorithm     = var.kms_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "convertr_block" {
  bucket = aws_s3_bucket.convertr.id

  # no need to variablize these
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "https_only" {
  bucket = aws_s3_bucket.convertr.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceHTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.convertr.arn}/*",
          aws_s3_bucket.convertr.arn
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
