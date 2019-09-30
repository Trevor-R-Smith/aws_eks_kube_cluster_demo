#
# Outputs
#
//output "config_map_aws_auth" {
//  value       = "${local.config_map_aws_auth}"
//  description = "Contents of aws-auth config map"
//}
//
//output "kubeconfig" {
//  value       = "${local.kubeconfig}"
//  description = "Contents of kubeconfig"
//}

output "kubeconfig_file" {
  value       = var.kube_config_file
  description = "Kubeconfig file path"
}

output "local_ip" {
  value       = local.workstation-external-cidr
  description = "Workstation public ip address"
}

output "istio_ingress_gateway" {
  value       = "kubectl get svc istio-ingressgateway --namespace istio-system -o jsonpath={.status.loadBalancer.ingress[0].hostname} --kubeconfig ${local_file.kube_config.filename}"
  description = "Istio ingress gateway"
}

output "eks_cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "The name of the eks cluster "
}

output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "The eks cluster endpoint detaisl"
}

output "eks_vpc_id" {
  value = aws_vpc.default.id
  description = "The Id of the vpc that has been created"

}

output "eks_vpc_subnets" {
  value = aws_subnet.default.*.availability_zone
  description = "The availabilty zones that the subnet have been deployed to"
}

output "key_pair_finger_print" {
  value = aws_key_pair.generated_key.public_key
  description = "The certificate of authority to communicate wth the cluster"
}
output "eks_vpc_info" {
  value = aws_subnet.default.*.id
  description = "The ids of the subnets that have been created inside the VPC"
}

output "keypair_name" {
  value = aws_key_pair.generated_key.key_name
  description = "The name of the key pair generated"
}
output "kubernetes_version" {
  value = aws_eks_cluster.eks.version
}

output "dns_address" {
  value = aws_autoscaling_group.eks-cluster.load_balancers
}