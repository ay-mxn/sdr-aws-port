variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_zip_file" {
  description = "Path to the Lambda deployment package"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "vpc_config" {
  description = "VPC configuration for the Lambda function"
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "log_retention_in_days" {
  description = "Number of days to retain Lambda logs"
  type        = number
  default     = 14
}

variable "maximum_event_age_in_seconds" {
  description = "Maximum age of a request that Lambda sends to a function for processing"
  type        = number
  default     = 21600 # 6 hours
}

variable "maximum_retry_attempts" {
  description = "Maximum number of times to retry when the function returns an error"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}