resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/eks/${local.cluster_name}/cluster"
  retention_in_days = var.eks_cloudwatch_retention

  tags = merge(local.common_tags, var.default_tags, map(
  "Name", "eks-cloudwatch-logs",
  "kubernetes.io/cluster/${local.cluster_name}", "shared"))

}