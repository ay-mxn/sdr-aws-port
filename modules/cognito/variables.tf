variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "client_name" {
  description = "Name of the Cognito User Pool Client"
  type        = string
}

variable "password_minimum_length" {
  description = "Minimum length of the password"
  type        = number
  default     = 8
}

variable "password_require_lowercase" {
  description = "Whether to require lowercase letters in passwords"
  type        = bool
  default     = true
}

variable "password_require_numbers" {
  description = "Whether to require numbers in passwords"
  type        = bool
  default     = true
}

variable "password_require_symbols" {
  description = "Whether to require symbols in passwords"
  type        = bool
  default     = true
}

variable "password_require_uppercase" {
  description = "Whether to require uppercase letters in passwords"
  type        = bool
  default     = true
}

variable "mfa_configuration" {
  description = "Multi-Factor Authentication (MFA) configuration for the User Pool"
  type        = string
  default     = "OFF"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}