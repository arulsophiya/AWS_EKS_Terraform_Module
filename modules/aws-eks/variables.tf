variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "worker_node_instance_type" {
  type = list(string)
}

variable "vpc_id" {
  type = string
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

variable "private_subnet_ids" {
  type = list(string)
}
