#
# Variables Configuration
#

locals {
  env = terraform.workspace

  common_tags = {
    "Environment" = local.env
    "Owner" = var.owner
    "Project" = var.project
    "Terraform"   = "true"
  }

}

variable "owner" {
  type    = "string"
  description = "The owner of the project"
}

variable "project" {
  type    = "string"
  description = "The name of the project"
}

variable default_tags {
  description = "Default tags to use on resources"
  type = map(string)
  default = {}

}

###########################
# EKS
###########################

variable "key_name" {
  type        = "string"
  description = "SSH key name"
}

variable "desired_nodes" {
  type        = string
  description = "ASG desired nodes"
}

variable "instance_type" {
  type        = "string"
  description = "Node instance type"
}

variable "min_nodes" {
  type        = "string"
  default     = 3
  description = "ASG min nodes"
}

variable "max_nodes" {
  type        = "string"
  default     = 5
  description = "ASG max nodes"
}

variable "region" {
  type        = "string"
  description = "AWS region"
}

variable "kube_config_file" {
  type        = string
  description = "Kubeconfig file to create"
}

variable "resource_prefix" {
  type        = string
  description = "Resource prefix"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}


###############################
# VPC
###############################


variable "network_cidr" {
  type        = string
  description = "Network CIDR"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the security groups from which to allow `ingress` traffic to the DB instance"
}

variable internal_cidr_block {
  type = string
  description = "The cidr block for gft"
}

variable "associate_security_group_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the existing security groups to associate with the DB instance"
}

###########################
# RDS
###########################
variable "availability_zone" {
description = "The AZ for the RDS instance"
  type = string
}

variable db_name {
  type = string
  description = "The name of the RDS instance"
}

variable db_username {
  type = string
  description = "The username for the DB instance"
}

variable "db_password"{
  type = string
  description = "The password for the DB instance"
}

variable "publicly_accessible" {
  type         = string
  description  = "Choose whether to make the RDS publically accessible"
  default      = true
}


variable "db_identifier" {
  type         = string
  description  = "The identifier of the  RDS instance"

}
variable "multi-az" {
  type         = string
  description  = "If the RDS is multi AZ"
  default      = false
}
variable "db_port" {
  type         = string
  description  = "The port number of the RDS"
  default      = "3306"
}

variable "instance_class" {
  type         = string
  description  = "The port number of the RDS"
  default      = "db.r5.xlarge"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "option_group_name" {
  description = "Name of the DB option group to associate. Setting this automatically disables option_group creation"
  type        = string
  default     = ""
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created"
  type        = bool
  default     = true

}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. 'Mon:00:00-Mon:03:00'"
  type = string
}

variable "backup_window" {
    description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
    type        = string
  }


# DB subnet group

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}

##################################
# DB option group
###################################

variable "option_group_description" {
  description = "The description of the option group"
  type        = string
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = [ "audit",  "error",  "general", "slowquery",  ]
}

variable "option_engine_name" {
  description = "The name of the option engine"
  type        = string
}

variable "major_engine_version" {
  description = "The option engine version"
  type        = string
}

variable "option_name" {
  description = "The name of the option group"
  type        = string
}

#############################
# PARAMETER GROUP
#############################

variable "parameter_family" {
  type         = string
  description  = "The parameter group name of the RDS"
}

##############################
# CLOUDWATCH
#############################

variable "eks_cloudwatch_retention" {
  description = "The number of days to retain log events in log group"
  type = string
  default = 7
}