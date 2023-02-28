resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  version  = "1.23"
  role_arn = aws_iam_role.eks-master.arn
  vpc_config {
    security_group_ids      = ["${aws_security_group.eks-master.id}"] #additional sec group
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.Cluster-Policy,
    aws_iam_role_policy_attachment.Service-Policy,
    aws_iam_role_policy_attachment.ecr-Policy
  ]
}