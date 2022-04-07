resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${terraform.workspace}-${var.project-name}-ng-1"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = var.private-subnet-ids
  instance_types  = [var.node_instance_type]

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }
  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  update_config {
    max_unavailable = 2
  }

  remote_access {
    ec2_ssh_key               = var.ec2-key-pair-name
    source_security_group_ids = [aws_security_group.eks-node-group.id]

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
