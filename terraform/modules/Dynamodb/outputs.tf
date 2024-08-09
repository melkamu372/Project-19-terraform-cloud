output "table_id" {
  description = "The ID of the DynamoDB table"
  value       = aws_dynamodb_table.terraform_locks.arn
}
