resource "aws_cognito_user_pool" "main" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers   = var.password_require_numbers
    require_symbols   = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
  }

  mfa_configuration = var.mfa_configuration

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "main" {
  name         = var.client_name
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}