resource "aws_eks_cluster" "eks_cluster" {
 name = "eks-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn
 
 vpc_config {
  subnet_ids = [var.Public_Subnet1_id,var.Public_Subnet2_id]
 }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-EKS,
  ]
}