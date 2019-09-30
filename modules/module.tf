################################
# BACKEND - MODULE
###############################

module "backend-state" {
  source = "./backend-state-file"

  restrict_public_buckets = var.restrict_public_buckets
  state_bucket_name = var.state_bucket_name
  acl = var.s3_bucket_acl
  block_public_acls = var.block_public_acls
  block_public_policy = var. block_public_policy

  dynamodb_name = var.dynamodb_name

#################
# TAGS
##################

  environment = local.env
  project = var.project
  region = var.region
  profile = var.profile
}


