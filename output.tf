# Output S3 bucket name
output "s3_bucket_name" {
  value       = module.S3.bucket_id
  description = "The name of the S3 bucket."
}

# Output DynamoDB table name
output "dynamodb_table_name" {
  value       = module.Dynamodb.table_id
  description = "The name of the DynamoDB table."
}
