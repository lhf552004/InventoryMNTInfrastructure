variable "lambda_role_name" {
  description = "Name of the IAM role for Lambda"
  type        = string
}

variable "assume_role_policy" {
  description = "IAM assume role policy document"
  type        = string
}

variable "ecr_access_policy" {
  description = "IAM policy for accessing ECR"
  type        = string
}
