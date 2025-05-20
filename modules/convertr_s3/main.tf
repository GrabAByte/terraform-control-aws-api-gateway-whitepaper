resource "aws_s3_bucket" "convertr" {
  bucket = "convertr-bucket" # var.bucket_name

  tags = { } # var.tags
}
