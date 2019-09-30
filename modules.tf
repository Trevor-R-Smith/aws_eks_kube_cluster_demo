
###################################
# EKS CLUSTER
##################################

module "eks_cluster" {
  source = "./modules/eks-cluster"

  ############
  # NODES
  ###########
  desired_nodes = var.desired_nodes
  key_name = var.key_name
  network_cidr = var.network_cidr
  region = var.region
  resource_prefix = var.resource_prefix
  instance_type = var.instance_type
  kube_config_file = var.kube_config_file

  ###########
  # RDS
  ##########
  availability_zone = var.availability_zone
  db_identifier = var.identifier
  db_name = var.db_name
  db_password = var.db_password
  db_username = var.db_username
  internal_cidr_block = var.internal_cidr_block
  backup_window = var.backup_window
  maintenance_window = var.maintenance_window
  parameter_family = var.parameter_family
  major_engine_version = var.major_engine_version
  option_engine_name = var.option_engine_name
  option_name = var.option_name


  ################
  # TAGS
  #################

  owner = var.owner
  project = var.project


}