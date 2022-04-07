#==================================================================================================
# ECR Lifecycle Policy for Auth Backend App ECR
#==================================================================================================
resource "aws_ecr_lifecycle_policy" "ecr-repo" {
  repository = aws_ecr_repository.ecr-repo.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last ${var.ecr-retention-num-of-images} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.ecr-retention-num-of-images}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
