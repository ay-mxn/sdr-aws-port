# variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}