resource "aws_iam_role" "lambda_execution_role" {
  name               = var.lambda_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "ecr_access_policy" {
  name   = "ECRAccessPolicy"
  role   = aws_iam_role.lambda_execution_role.id
  policy = var.ecr_access_policy
}
