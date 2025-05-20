resource "aws_s3_bucket" "convertr" {
  bucket = "convertr-bucket"

  tags = {
    Name        = "convertr"
    Environment = local.environment
  }
}
