output "secret_arn" {
  description = "ARN of the secret"
  value       = aws_secretsmanager_secret.main.arn
}

output "secret_id" {
  description = "ID of the secret"
  value       = aws_secretsmanager_secret.main.id
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = var.create_secret_version ? aws_secretsmanager_secret_version.main[0].version_id : null
}