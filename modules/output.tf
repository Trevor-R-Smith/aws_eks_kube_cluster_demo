output "s3_bucket_name" {
  value = module.backend-state.s3_bucket_domain_name
}

output "dynamo_db_name" {
  value = module.backend-state.dynamodb_table_name
}

output "s3_bucket_info" {
  value = module.backend-state.s3_bucket_id
}
output "backend-template" {
  value = module.backend-state.terraform_backend_config
}