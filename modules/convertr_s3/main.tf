resource "aws_s3_bucket" "image_bucket" {
  bucket        = "convertr-upload-bucket"
  force_destroy = true
}
