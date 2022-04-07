#==================================================================================================
# IAM Role Policy Attachmend - AmazonEKSClusterPolicy
#==================================================================================================
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
  role       = aws_iam_role.eks-cluster.name
}
#==================================================================================================
# IAM Role Policy Attachmend - AmazonEKSVPCResourceController
#==================================================================================================
# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = data.aws_iam_policy.AmazonEKSVPCResourceController.arn
  role       = aws_iam_role.eks-cluster.name
}
#==================================================================================================
# IAM Role Policy Attachmend - AmazonEKSWorkerNodePolicy
#==================================================================================================
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn
  role       = aws_iam_role.node-group.name
}
#==================================================================================================
# IAM Role Policy Attachmend - AmazonEKS_CNI_Policy
#==================================================================================================
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = data.aws_iam_policy.AmazonEKS_CNI_Policy.arn
  role       = aws_iam_role.node-group.name
}
#==================================================================================================
# IAM Role Policy Attachmend - AmazonEC2ContainerRegistryReadOnly
#==================================================================================================
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
  role       = aws_iam_role.node-group.name
}
