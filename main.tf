# main.tf

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "vpc-${var.environment}"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "igw-${var.environment}"
    Environment = var.environment
  }
}

# Subnets
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "subnet-public-${var.environment}-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "subnet-private-${var.environment}-${count.index + 1}"
    Environment = var.environment
  }
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "rt-public-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "main" {
  name        = "sg-main-${var.environment}"
  description = "Main security group for ${var.environment}"
  vpc_id      = aws_vpc.main.id

  # Define ingress and egress rules here

  tags = {
    Name        = "sg-main-${var.environment}"
    Environment = var.environment
  }
}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# ECS Cluster (equivalent to App Service Plan)
resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster-${var.environment}"

  tags = {
    Environment = var.environment
  }
}

# ECR Repository (equivalent to Azure Container Registry)
resource "aws_ecr_repository" "main" {
  name = "ecr-${var.environment}"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }
}

# DynamoDB Table (equivalent to Cosmos DB)
resource "aws_dynamodb_table" "main" {
  name           = "dynamodb-${var.environment}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = var.environment
  }
}

# API Gateway (equivalent to API Management)
resource "aws_api_gateway_rest_api" "main" {
  name        = "api-gateway-${var.environment}"
  description = "API Gateway for SDR"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Environment = var.environment
  }
}

# Lambda Function (equivalent to Function App)
resource "aws_lambda_function" "main" {
  filename      = "lambda_function.zip"
  function_name = "lambda-${var.environment}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = {
    Environment = var.environment
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# S3 Bucket (for storing artifacts, logs, etc.)
resource "aws_s3_bucket" "main" {
  bucket = "sdr-${var.environment}-${random_id.bucket_suffix.hex}"

  tags = {
    Environment = var.environment
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

# CloudWatch Log Group (equivalent to Log Analytics Workspace)
resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/sdr/${var.environment}"

  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}

# SQS Queue (equivalent to Service Bus)
resource "aws_sqs_queue" "main" {
  name = "sqs-${var.environment}"

  tags = {
    Environment = var.environment
  }
}

# Secrets Manager (equivalent to Key Vault)
resource "aws_secretsmanager_secret" "main" {
  name = "secrets-${var.environment}"

  tags = {
    Environment = var.environment
  }
}

# Cognito User Pool (equivalent to Azure AD)
resource "aws_cognito_user_pool" "main" {
  name = "user-pool-${var.environment}"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  tags = {
    Environment = var.environment
  }
}

# ECS Service and Task Definition (equivalent to App Service)
resource "aws_ecs_task_definition" "app" {
  family                   = "app-task-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "app-container"
      image = "${aws_ecr_repository.main.repository_url}:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "app-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.main.id]
  }
}

# ECR
module "ecr" {
  source = "./modules/ecr"

  repository_name = "${var.project_name}-${var.environment}"
  tags            = var.tags
}

#SQS
module "sqs" {
  source = "./modules/sqs"

  queue_name = "${var.project_name}-${var.environment}-queue"
  tags       = var.tags
}