output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "api_gateway_id" {
  value = module.api_gateway.api_id
}

output "iam_role_arn" {
  value = module.iam.role_arn
}
