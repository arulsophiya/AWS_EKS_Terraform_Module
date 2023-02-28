provider "aws" {
  region = var.region
}

locals {
  env = terraform.workspace
}

data "aws_availability_zones" "available" {}

resource "aws_eip" "nat" {
  count = 3
  vpc   = true
}

module "vpc" {
  source          = "../modules/vpc"
  name            = "${var.vpc_name}-${local.env}"
  cidr            = var.cidr_block
  azs             = data.aws_availability_zones.available.names //list of azs
  private_subnets = var.private_subnets
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" : "1"
  }
  public_subnets = var.public_subnets
  public_subnet_tags = {
    "kubernetes.io/role/elb" : "1"
  }
  enable_nat_gateway   = true
  single_nat_gateway   = false
  reuse_nat_ips        = true
  external_nat_ip_ids  = aws_eip.nat.*.id
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Terraform" : "true"
    "Environment" : local.env
    "kubernetes.io/cluster/${var.cluster_name}" : "shared"
  }
}

module "production-eks" {
  source             = "../modules/aws-eks"
  cluster_name       = var.cluster_name
  private_subnet_ids = module.vpc.private_subnets
  env                = local.env
  vpc_id             = module.vpc.vpc_id
  worker_node_instance_type         = var.worker_node_instance_type
  worker_nodes_scaling_desired_size = var.worker_nodes_scaling_desired_size
  worker_nodes_scaling_max_size     = var.worker_nodes_scaling_max_size
  worker_nodes_scaling_min_size     = var.worker_nodes_scaling_min_size
}