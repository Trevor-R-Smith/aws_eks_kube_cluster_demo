##########################################
#DYNAMO DB LOCK TABLE
##########################################

resource "aws_dynamodb_table" "terraform_state" {
  name           = var.dynamodb_name
  hash_key       = "LockID"
  read_capacity  = 10
  write_capacity = 10

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
     local.common_tags,
     map(
       "Name", var.dynamodb_name

     )
   )
}

##########################################
#S3 STATE BUCKET
##########################################

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name
  acl    = var.acl
  region = var.region

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
     local.common_tags,
     map(
       "Name", var.state_bucket_name

     )
   )
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}

###################################
# TEMPLATE FILE
###################################

data "template_file" "terraform_backend_config" {
  template = file("${path.module}/templates/terraform.tf.tpl")

  vars = {
    region = var.region
    bucket = aws_s3_bucket.terraform_state.id
    encrypt              = var.enable_server_side_encryption ? "true" : "false"
    dynamodb_table = coalescelist(
    aws_dynamodb_table.terraform_state.*.name,
    )[0]

    role_arn             = var.role_arn
    terraform_state_file = var.terraform_state_file
  }
}

resource "local_file" "terraform_backend_config" {

  content  = data.template_file.terraform_backend_config.rendered
  filename = local.terraform_backend_config_file
}