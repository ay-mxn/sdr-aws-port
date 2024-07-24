output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.main.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.main.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.main.id
}

output "table_stream_arn" {
  description = "The ARN of the Table Stream. Only available when stream_enabled = true"
  value       = var.stream_enabled ? aws_dynamodb_table.main.stream_arn : null
}

output "table_stream_label" {
  description = "A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream_enabled = true"
  value       = var.stream_enabled ? aws_dynamodb_table.main.stream_label : null
}