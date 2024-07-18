output "api_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.id
}

output "api_arn" {
  description = "ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.arn
}

output "invoke_url" {
  description = "Invoke URL for the API Gateway stage"
  value       = aws_api_gateway_deployment.main.invoke_url
}

output "execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.execution_arn
}

output "custom_domain_url" {
  description = "URL of the custom domain (if configured)"
  value       = var.custom_domain != "" ? "https://${var.custom_domain}" : null
}