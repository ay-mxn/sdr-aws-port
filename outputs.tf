output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs_service.service_name
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda.function_name
}

output "api_gateway_invoke_url" {
  description = "The URL to invoke the API Gateway"
  value       = module.api_gateway.invoke_url
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "secrets_manager_secret_arn" {
  description = "The ARN of the Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = module.cloudwatch.log_group_name
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = module.sqs.queue_id
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs.queue_arn
}