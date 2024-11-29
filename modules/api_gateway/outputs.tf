output "api_id" {
  value = aws_apigatewayv2_api.this.id
}

output "stage_name" {
  value = aws_apigatewayv2_stage.api_stage.name
}
