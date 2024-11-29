resource "aws_ecr_repository" "inventory_repository" {
  name = var.ecr_name
}

resource "aws_ecr_repository_policy" "lambda_access_policy" {
  repository = aws_ecr_repository.inventory_repository.name
  policy = var.ecr_policy
}
