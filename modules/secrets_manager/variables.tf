variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "ARN or Id of the AWS KMS key to be used to encrypt the secret values in the versions stored in this secret"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_secret_version" {
  description = "Whether to create an initial secret version"
  type        = bool
  default     = false
}

variable "secret_string" {
  description = "Specifies text data that you want to encrypt and store in this version of the secret"
  type        = string
  default     = null
}

variable "policy" {
  description = "Valid JSON document representing a resource policy"
  type        = string
  default     = null
}

variable "enable_rotation" {
  description = "Specifies whether automatic rotation is enabled for this secret"
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "Specifies the ARN of the Lambda function that can rotate the secret"
  type        = string
  default     = null
}

variable "rotation_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret"
  type        = number
  default     = 30
}