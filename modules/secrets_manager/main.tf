resource "aws_secretsmanager_secret" "main" {
  name                    = var.secret_name
  description             = var.description
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.recovery_window_in_days

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "main" {
  count         = var.create_secret_version ? 1 : 0
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = var.secret_string
}

resource "aws_secretsmanager_secret_policy" "main" {
  count      = var.policy != null ? 1 : 0
  secret_arn = aws_secretsmanager_secret.main.arn
  policy     = var.policy
}

resource "aws_secretsmanager_secret_rotation" "main" {
  count               = var.enable_rotation ? 1 : 0
  secret_id           = aws_secretsmanager_secret.main.id
  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
}