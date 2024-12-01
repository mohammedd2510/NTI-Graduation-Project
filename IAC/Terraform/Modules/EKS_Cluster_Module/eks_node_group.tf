resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [var.Public_Subnet1_id,var.Public_Subnet2_id]
  instance_types = ["t2.large"]
  remote_access {
    ec2_ssh_key = var.my_key # Specify your SSH key name here
    source_security_group_ids = [var.security_group_id]
  }
  disk_size = 20  # Set EBS volume size to 20GB
 
  scaling_config {
   desired_size = 2
   max_size   = 3
   min_size   = 2
  }
   tags = {
    Name = "eks-node-group"
  }
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
 resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_node_group" {
  security_group_id =  aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
