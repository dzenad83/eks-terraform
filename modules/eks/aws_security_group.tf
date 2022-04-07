#==================================================================================================
# ECS Service Security Group for Backend App - AUTH
#==================================================================================================
resource "aws_security_group" "eks-node-group" {
  name        = "${lower(terraform.workspace)}-${lower(var.project-name)}-eks-node-group"
  description = "Security Group for Node Group on ${upper(terraform.workspace)} of ${upper(var.project-name)} project"
  vpc_id      = var.vpc-id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${lower(terraform.workspace)}-${lower(var.project-name)}-eks-node-group"
    Environment = "${lower(terraform.workspace)}"
  }
}
