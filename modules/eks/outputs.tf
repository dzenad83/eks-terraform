#==================================================================================================
# EKS Cluster output
#==================================================================================================
output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}
#==================================================================================================
# EKS Cluster Certificate Authority
#==================================================================================================
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}
