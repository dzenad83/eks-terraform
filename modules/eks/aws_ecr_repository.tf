#==================================================================================================
# ECR for Auth Backend App 
#==================================================================================================
resource "aws_ecr_repository" "ecr-repo" {
  name = "${lower(terraform.workspace)}-${lower(var.project-name)}-ecr-repo"

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms-key
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${lower(terraform.workspace)}-${lower(var.project-name)}-ecr-repo"
    Environment = "${lower(terraform.workspace)}"
  }
}
