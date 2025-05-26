output "invoke_url" {
  value = "${aws_api_gateway_stage.stage.invoke_url}/${aws_api_gateway_resource.upload.path_part}"
}
