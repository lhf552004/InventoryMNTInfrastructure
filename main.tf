provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source   = "./modules/ecr"
  ecr_name = var.ecr_name
  ecr_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowLambdaAccess",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : module.iam.role_arn
        },
        "Action" : [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}

module "iam" {
  source           = "./modules/iam"
  lambda_role_name = var.lambda_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  ecr_access_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ],
        "Resource" : module.ecr.repository_arn
      }
    ]
  })
}

module "api_gateway" {
  source           = "./modules/api_gateway"
  api_gateway_name = var.api_gateway_name
}
