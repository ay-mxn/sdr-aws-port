output "log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.main.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.main.arn
}

output "alarm_arns" {
  description = "List of ARNs of the CloudWatch alarms"
  value       = aws_cloudwatch_metric_alarm.main[*].arn
}

output "dashboard_arn" {
  description = "ARN of the CloudWatch dashboard"
  value       = var.create_dashboard ? aws_cloudwatch_dashboard.main[0].dashboard_arn : null
}