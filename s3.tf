resource "aws_s3_bucket" "image_bucket" { # W: Bucket does not encrypt data with a customer managed key.
  bucket = "image-upload-bucket"
}
