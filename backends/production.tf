terraform {
  required_version = ">= 1.11"

  backend "s3" {
    bucket  = "grababyte-tfstate"
    key     = "convertr/convertr.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
