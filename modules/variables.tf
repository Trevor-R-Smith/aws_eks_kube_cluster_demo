locals {
  env = terraform.workspace

}

variable "region" {
  default = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}
#########################
# BACKEND S3/ DYNAMO_DB
#########################

variable "state_bucket_name" {
  type = string
  description = "The name of the S3 bucket"
}

variable dynamodb_name {
  type = string
  description = "The name of the dynamo DB"
}

variable "restrict_public_buckets"{
  type = bool
  description = "If true Only the bucket owner and AWS Services can access this buckets if it has a public policy "
  default = true
}

variable "s3_bucket_acl"{
  type = string
  description = "The acl of the s3 bucket"
  default = "private"
}
variable "block_public_acls" {
  type = bool
  description = "If true PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access "
  default = false
}

variable  "block_public_policy" {
  type = bool
  description = "If true Ignore public ACLs on this bucket and any objects that it contains "
  default = false
}

variable "profile" {
  type = string
  description = "The owner/creator "
}

variable "project" {
  type = string
  description = "The name of the project "
}
