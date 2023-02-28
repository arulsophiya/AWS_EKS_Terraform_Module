resource "aws_security_group" "eks-master" {
  name        = "eks-cluster-sg-${var.cluster_name}"
  description = "Master security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allows inbound only from specific IPs"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allows all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform   = "true"
    Environment = var.env
    Nodes       = "${var.cluster_name}-master"
  }

}