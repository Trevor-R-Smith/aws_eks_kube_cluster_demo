#AWS auth config map to join nodes to the cluster
resource "kubernetes_config_map" "aws_auth_configmap" {
  metadata  {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<CONFIGMAPAWSAUTH
    - rolearn: ${aws_iam_role.eks-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes

CONFIGMAPAWSAUTH
  }

  depends_on = [
    "local_file.kube_config",
    "aws_eks_cluster.eks",
    "aws_autoscaling_group.eks-cluster",
  ]
}
