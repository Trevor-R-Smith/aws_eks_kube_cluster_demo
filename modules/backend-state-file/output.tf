output "s3_bucket_domain_name" {
  value       = aws_s3_bucket.terraform_state.bucket_domain_name
  description = "S3 bucket domain name"
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.terraform_state.id
  description = "S3 bucket ID"
}

output "dynamodb_table_name" {
  value = coalescelist(
  aws_dynamodb_table.terraform_state.*.name,
  )[0]
  description = "DynamoDB table name"
}

output "terraform_backend_config" {
  value       = data.template_file.terraform_backend_config.rendered
  description = "Rendered Terraform backend config file"
}