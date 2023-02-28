resource "aws_eks_node_group" "eks-workers" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${aws_eks_cluster.eks.name}-Nodes"
  node_role_arn   = aws_iam_role.eks-workers.arn
  subnet_ids      = var.private_subnet_ids
  instance_types = var.worker_node_instance_type
  version        = "1.23"

  scaling_config {
    desired_size = var.worker_nodes_scaling_desired_size
    max_size     = var.worker_nodes_scaling_max_size
    min_size     = var.worker_nodes_scaling_min_size
  }
  depends_on = [
    "aws_eks_cluster.eks",
    "aws_iam_role_policy_attachment.workers-Policy",
    "aws_iam_role_policy_attachment.cni-Policy",
    "aws_iam_role_policy_attachment.ecr-Policy"
  ]
  tags = {
    Name        = "${aws_eks_cluster.eks.name}-worker-nodes"
    Terraform   = "true"
    Environment = var.env
  }
}
