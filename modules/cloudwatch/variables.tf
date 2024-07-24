variable "log_group_name" {
  description = "The name of the log group"
  type        = string
}

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "alarms" {
  description = "List of alarm configurations"
  type = list(object({
    name                = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    alarm_description   = string
    alarm_actions       = list(string)
    dimensions          = map(string)
  }))
  default = []
}

variable "create_dashboard" {
  description = "Whether to create a CloudWatch dashboard"
  type        = bool
  default     = false
}

variable "dashboard_name" {
  description = "Name of the dashboard"
  type        = string
  default     = null
}

variable "dashboard_body" {
  description = "The detailed information about the dashboard in JSON format"
  type        = string
  default     = null
}