output "api_endpoint" {
  description = "API Gateway endpoint"
  value       = aws_api_gateway_deployment.deployment.invoke_url
}
output "api_id" {
  description = "API Gateway ID"
  value       = aws_api_gateway_rest_api.api.id
}
