# Use the aws_instance data source to retrieve instances that are tagged as EKS worker nodes
data "aws_instances" "example" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [aws_eks_node_group.worker-node-group.node_group_name]
  }

  filter {
    name   = "tag:eks:cluster-name"
    values = [aws_eks_cluster.eks_cluster.name]
  }
}

# Output the public IPs of all instances in the EKS node group
output "worker_node_public_ips" {
  value = data.aws_instances.example.public_ips
}

