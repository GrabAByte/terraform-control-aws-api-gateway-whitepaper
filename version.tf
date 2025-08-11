terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.7"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }

  backend "s3" {
    bucket  = "grababyte-api-gateway-whitepaper-tfstate"
    key     = "tfstate"
    region  = "eu-west-2"
    encrypt = true
  }

  # ubuntu 22.04 used as github runner as it has terraform baked
  # 1.11 latest version available on this build
  required_version = ">= 1.11"
}
