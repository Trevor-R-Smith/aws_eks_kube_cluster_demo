output "eks_cluster_name"{
  value = module.eks_cluster.eks_cluster_name
  description = "The name of the EKS Cluster"
}

output "eks_endpoint" {
  value = module.eks_cluster.eks_cluster_endpoint
  description = "The EKS Cluster endpoint"
}

output "eks_vpc_id" {
  value = module.eks_cluster.eks_vpc_id
  description = "The EKS Cluster VPC ID"
}
output "eks_cluster_info" {
  value = module.eks_cluster.local_ip
  description = "THe local IP of the EKS Cluster "
}

output "key_pair_finger_print" {
  value = module.eks_cluster.key_pair_finger_print
  description = "The certificate of authority to communicate wth the cluster"
}

output "local_kube_config" {
  value = module.eks_cluster.kubeconfig_file
  description = "The kube config path"
}