locals {
  terraform_backend_config_file = format(
  "%s/%s",
  var.terraform_backend_config_file_path,
  var.terraform_backend_config_file_name
  )
}

variable "region" {
  type        = string
  description = "AWS Region the S3 bucket should reside in"
}

variable "dynamodb_name" {
  type    = "string"
  description = "name of the dynamodb table "
}

variable "acl" {
  type    = "string"
  description = "the bucket acl "
}

variable "state_bucket_name"{
  type    = "string"
  description = "name of the s3 statae bucket "
}

variable "environment" {
  type    = "string"
  description = "The environment that is being build"
}

variable "profile" {
  type    = "string"
  description = "The owner of the project"
}

variable "project" {
  type    = "string"
  description = "The name of the project"
}

variable "block_public_acls" {
  type    = bool
  description = "If true PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access "
}

variable "block_public_policy" {
  type    = bool
  description = "If true Ignore public ACLs on this bucket and any objects that it contains "
}

variable "restrict_public_buckets" {
  type    = bool
  description = "If true Only the bucket owner and AWS Services can access this buckets if it has a public policy "
}


locals {
  common_tags = {
    Environment = var.environment
    Owner = var.profile
    Project = var.project
    Terraform = "true"
  }
}

variable "role_arn" {
  type        = string
  default     = ""
  description = "The role to be assumed"
}
variable "terraform_state_file" {
  type        = string
  default     = "terraform.tfstate"
  description = "The path to the state file inside the bucket"
}

variable "terraform_backend_config_file_name" {
  type        = string
  default     = "terraform.tf"
  description = "Name of terraform backend config file"
}

variable "terraform_backend_config_file_path" {
  type        = string
  default     = ".."
  description = "The path to terrafrom project directory"
}

variable "enable_server_side_encryption" {
  type        = bool
  description = "Enable DynamoDB server-side encryption"
  default     = true
}