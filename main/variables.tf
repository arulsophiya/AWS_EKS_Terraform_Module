variable "project_name" {
  type    = string
  default = "EKS"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "cluster_name" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "EKS-VPC"
}

variable "cidr_block" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "worker_node_instance_type" {
  type = list(string)
}

variable "worker_nodes_scaling_desired_size" {
  type = string
}

variable "worker_nodes_scaling_max_size" {
  type = string
}

variable "worker_nodes_scaling_min_size" {
  type = string
}

