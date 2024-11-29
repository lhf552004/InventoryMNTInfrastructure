output "repository_name" {
  value = aws_ecr_repository.inventory_repository.name
}

output "repository_arn" {
  value = aws_ecr_repository.inventory_repository.arn
}
