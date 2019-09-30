locals {
  env = terraform.workspace

  common_tags = {
      Environment = local.env
      Owner = var.owner
      Project = var.project
      Terraform = "true"
    }
  }

variable "region" {
  type        = string
  description = "AWS region"
}

variable "internal_cidr_block" {
  type = string
  description = "The local internal cidr block range "
}

variable "owner" {
  type    = "string"
  description = "The owner of the project"
}

variable "project" {
  type    = "string"
  description = "The name of the project"
}
#####################
# EKS-CLUSTER
#####################

variable "desired_nodes" {
  type = number
  description = "number of nodes to deploy "
}

variable "key_name" {
  type = string
  description = "The key pair name "

}

variable "network_cidr" {
  type = string
  description = "The network cidr block range "
}

variable "resource_prefix" {
  type = string
  description = "The resources prefix name "
}
variable "instance_type" {
  type = string
  description = "The instance class to deploy  "
  default = "t3.large"
}

variable "kube_config_file" {
  type = string
  description = "path to the kube config file "
}

######################
# RDS
######################

variable "availability_zone" {
  description = "The AZ of the RDS"
  type = string
  default = "eu-west-1a"
}

variable "identifier" {
  type = string
  description = "The idenitifer of the RDS instance  "

}

variable "db_name" {
  type = string
  description = "The name of the  RDS instance  "
}

variable "db_password" {
  type = string
  description = "The password of the rds instance   "
}

variable "db_username" {
  type = string
  description = "The usernme of the RDS instance  "
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'"
  type = string
  default = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
    description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Must not overlap with maintenance_window"
    type        = string
    default     = "05:00-08:00"
  }

variable "parameter_family" {
  description = "The rds parameter family"
  type        = string
  default     = "mysql5.7"
}

variable "major_engine_version"{
  description = "The name of the option group"
  type        = string
  default     = "5.7"
}

variable "option_engine_name" {
  description = "The name of the option group"
  type        = string
  default     = "mysql"
}

variable "option_name" {
  description = "The name of the option group"
  type        = string
  default     = "MARIADB_AUDIT_PLUGIN"
}

############################
# LAMBDA
######################

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type = string
  default = "update-config"
}
variable "lambda_file" {
  description = "The path to the function's deployment package within the local filesystem."
  type = string
  default = "./update-config.zip"
}
variable "lambda_handler" {
  description = "The function entrypoint in your code."
  type = string
  default = "function.handler"
}
variable "lambda_runtime" {
  description = "The runtime for the lambda"
  type = string
  default = "python3.7"
}


################################
# S3
############################

variable "s3_acl" {
  description = "access control list for bucket default is private"
  type = string
  default = "private"

}
variable "s3_bucket_name" {
  description = "S3 bucket name"
  type = string
}

variable "bucket-key" {
  description = "The name of the object to put inside the s3 bucket"
  type = string
  default = "environment.ts"
}

#########################################
# FRONT END CONFIG
#################################

locals {
  terraform_backend_config_file = format(
  "%s/%s",
  var.frontend_config_file_path,
  var.frontend_config_file_name
  )
}

variable "config_version" {
  description = "The config file version"
  type        = string
}
variable "https" {
  description = "Does the backend use http or https"
  type        = string
  default     = "true"
}

variable "frontend_config_file_name" {
  description = "The path to place the config file"
  type = string
  default  = "/"
}
variable "frontend_config_file_path" {
  description = "The path to place the config file"
  type = string
  default  = "."
}