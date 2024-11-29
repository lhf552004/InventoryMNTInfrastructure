variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "lambda_role_name" {
  description = "Name of the IAM role for Lambda"
  type        = string
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
}
