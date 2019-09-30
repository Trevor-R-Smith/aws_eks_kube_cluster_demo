############################
# RDS INSTANCE
############################

resource "aws_db_instance" "default" {

  availability_zone    = var.availability_zone
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = var.publicly_accessible
  parameter_group_name = aws_db_parameter_group.default.id
  db_subnet_group_name = aws_db_subnet_group.default.id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  skip_final_snapshot = var.skip_final_snapshot
  identifier           = var.db_identifier
  multi_az             = var.multi-az
  port                 = var.db_port
  vpc_security_group_ids = compact(
  concat(
  [join("", aws_security_group.default.*.id)],
  var.associate_security_group_ids
  )
  )

  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  maintenance_window = var.maintenance_window
  backup_window      = var.backup_window

  tags = merge(local.common_tags, var.default_tags, map(
  "Name", "${var.resource_prefix}-db-instance",
  "kubernetes.io/cluster/${local.cluster_name}", "shared",))
}

#########################
# PARAMETER GROUP
########################

resource "aws_db_parameter_group" "default" {
  name = "${var.db_name}-pg"
  family = var.parameter_family

  tags = merge(local.common_tags, var.default_tags, map(
  "Name", "${var.resource_prefix}-db-instance",
  "kubernetes.io/cluster/${local.cluster_name}", "shared",))

}

#########################
# OPTIONS GROUP
########################

resource "aws_db_option_group" "default" {
  name = "${var.db_name}-og"
  option_group_description = "Terraform Option Group"
  engine_name = var.option_engine_name
  major_engine_version = var.major_engine_version

  option {
    option_name = var.option_name
  }

  tags = merge(local.common_tags, var.default_tags,map(
  "Name", "${var.resource_prefix}-option-group",
  "kubernetes.io/cluster/${local.cluster_name}", "shared",))
}

##########################
# SUBNETS
#########################

resource "aws_db_subnet_group" "default" {

  name       = "${var.db_name}-subnet-group"
  subnet_ids =  aws_subnet.default.*.id

  tags = merge(local.common_tags, var.default_tags,map(
  "Name", "${var.resource_prefix}-option-group",
  "kubernetes.io/cluster/${local.cluster_name}", "shared",))

}

#################################
# SECURITY GROUPS
##################################
resource "aws_security_group" "default" {
  name        = "${var.db_name}-sg"
  description = "Allow rds inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [var.internal_cidr_block]
    security_groups = [
      aws_security_group.eks-node.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = map(
  "Name", "${var.resource_prefix}-db-security-group",
  "kubernetes.io/cluster/${local.cluster_name}", "shared",
  )
}
