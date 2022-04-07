#==================================================================================================
# AWS EKS Cluster
#==================================================================================================

resource "aws_eks_cluster" "eks-cluster" {
  name     = "${terraform.workspace}-${var.project-name}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    subnet_ids = var.private-subnet-ids

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
