# terraform-control-aws-api-lambda-trigger-to-s3

## Project name and introduction
Grababyte projects look to follow the naming pattern of "$technology-$provider-$project"

The project looks to accomplish the following cloud architecture -

### Objectives

Create an AWS infrastructure consisting of the following components:

- AWS API Gateway: To act as the entry point for requests.
- AWS S3 Bucket: To store data.
- AWS Lambda Function: To process requests and interact with the S3 bucket.
- Private VPC: To host the Lambda function securely.

### Requirements

- The Lambda function must be deployed within a private Virtual Private Cloud (VPC).
- The API Gateway should trigger the Lambda function upon receiving requests.
- The Lambda function should have the necessary permissions to read and write data to
the S3 bucket.
- All AWS resources must be deployed with terraform tool.

### Expected Outcome

A functional AWS infrastructure that allows interaction with an S3 bucket through an API
endpoint, with the processing logic running in a Lambda function within a private VPC.

## repository structure

```
├── .github
│   └── workflows
├── backends
├── docs
└── test
    └── bats
        └── api
```

## Table of contents

- Requirements
- Recommended modules
- Installation
- Configuration
- Troubleshooting
- FAQ
- Maintainers

## Requirements

The following will need to be installed to run this project -

- an AWS account to deploy into 
- setup of AWS credentials configuration within local environment
- terraform for running the Infrastructure-as-Code
- postman for testing the API gateway
- python3 for developing and testing the lambda

## Recommended modules

The following modules will be installed when running `terraform init` -

```
https://github.com/GrabAByte/terraform-module-aws-lambda
https://github.com/GrabAByte/terraform-module-aws-api-gateway
https://github.com/GrabAByte/terraform-module-aws-vpc
https://github.com/GrabAByte/terraform-module-aws-s3
```

## Installation

The following commands can be ran to initialize and deploy the code

```
# ensure you have changed directory into the repository

tflint || docker run --rm -v $(pwd):/data -t ghcr.io/terraform-linters/tflint

# where $environment is the environment you want to use
# install providers and dependencies
terraform init -backend-config=backends/$environment.tf && \
  terraform workspace new $environment || \
  terraform workspace select $environment

# validate the code is syntactically correct
terraform validate

# (optional) perform a security posture scan of terraform code
tfsec || docker run --rm -v $(pwd):/src aquasec/tfsec /src

# plan terraform
terraform plan

# if ready to deploy infrastructure
terraform apply

# if ready to destroy infrastructure
terraform destroy
```

## Configuration

- AWS Access key and Access Key ID should be stored in ~/.aws/credentials, with the ini block header as [default]
- Terraform can be installed with the following instructions - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Python binaries can be downloaded and installed from the following URL - https://www.python.org/downloads/
~ Postman can be downloaded and install from the following URL - https://www.postman.com/downloads/

## Troubleshooting & FAQ

The API can be tested with the following command -

```
# within the repository directory

cd ./test
./api-call.sh https://${API_ID}.execute-api.eu-west-2.amazonaws.com/v1beta1/upload ${UPLOAD_IMAGE_FILE}
```

Functionality to upload an image as base64 encoded and the lambda to return a pre-signed URL is currently WIP

## Maintainers

This repository is maintained by GrabAByte.
