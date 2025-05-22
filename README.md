# terraform-aws-convertr-demo

## Project name and introduction
Grababyte projects look to follow the same naming pattern on <technology>-<provider>-<project>

The following project looks to accomplish the following cloud architecture -

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
├── backends - environment specific configuration
├── modules  - modules in use for the architecture
│   ├── convertr_api_gateway
│   ├── convertr_lambda
│   ├── convertr_s3
│   └── convertr_vpc
└── test    - forked python test script for regression testing secruity hardening
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

The following will need to be install in order to run this project -

- An AWS account to deply into 
- Setup of AWS credentials configuration within local environment
- terraform for running the Infrastrucure-as-Code
- python3 for developing and testing the lambda
- postman for testing the API gateway

## Recommended modules

Modules can be found in the following directory -

- ./modules/<module>/ (terraform)
- python modules are handled by the lambda functionality and no requirements.txt is required

## Installation

The following commands can be ran to initialize and deploy the code

```
# ensure you have changed directory into the repository

terraform init

terraform validate

tfsec

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

At present when terraform provisiones the convertr_api_gateway module, postman returns a 500 internal server error, when setting up the api gateway in AWS through ClickOps and integrating with other deployed resouces deployed with Terraform it works with the clean 200 status code.

## Maintainers

This repository is maintained by GrabAByte.
