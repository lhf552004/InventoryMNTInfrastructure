terraform {
  backend "s3" {
    bucket         = "inventory-infra-terraform-state-bucket"
    key            = var.state_key
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}