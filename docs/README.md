<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.13.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | github.com/GrabAByte/terraform-module-aws-api-gateway | feat/authorizer |
| <a name="module_dynamodb_download"></a> [dynamodb\_download](#module\_dynamodb\_download) | github.com/GrabAByte/terraform-module-aws-dynamo-db | v1.1.0 |
| <a name="module_dynamodb_upload"></a> [dynamodb\_upload](#module\_dynamodb\_upload) | github.com/GrabAByte/terraform-module-aws-dynamo-db | v1.1.0 |
| <a name="module_lambda_auth"></a> [lambda\_auth](#module\_lambda\_auth) | github.com/GrabAByte/terraform-module-aws-lambda | feat/tracing |
| <a name="module_lambda_download"></a> [lambda\_download](#module\_lambda\_download) | github.com/GrabAByte/terraform-module-aws-lambda | feat/tracing |
| <a name="module_lambda_upload"></a> [lambda\_upload](#module\_lambda\_upload) | github.com/GrabAByte/terraform-module-aws-lambda | feat/tracing |
| <a name="module_s3"></a> [s3](#module\_s3) | github.com/GrabAByte/terraform-module-aws-s3 | feat/enable_encryption |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/GrabAByte/terraform-module-aws-vpc | v1.2.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_attributes"></a> [dynamodb\_attributes](#input\_dynamodb\_attributes) | List of DynamoDB table attributes | <pre>list(object({<br/>    name = string<br/>    type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_environment_map"></a> [environment\_map](#input\_environment\_map) | The environment lookup for each workspace | `map(any)` | <pre>{<br/>  "development": "development",<br/>  "pre-production": "pre-production",<br/>  "production": "production"<br/>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which to deploy | `string` | `"eu-west-2"` | no |
| <a name="input_vpc_nacl_rules"></a> [vpc\_nacl\_rules](#input\_vpc\_nacl\_rules) | List of ingress and egress NACL rules | <pre>list(object({<br/>    rule_number = number<br/>    protocol    = string<br/>    rule_action = string<br/>    egress      = bool<br/>    cidr_block  = string<br/>    from_port   = number<br/>    to_port     = number<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | n/a |
| <a name="output_routes"></a> [routes](#output\_routes) | n/a |
<!-- END_TF_DOCS -->
