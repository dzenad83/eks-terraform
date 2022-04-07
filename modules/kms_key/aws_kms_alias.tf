#==================================================================================================
# KMS Key Alias
#==================================================================================================
resource "aws_kms_alias" "kms-alias" {
  name          = "alias/kms-key-${var.project-name}-${terraform.workspace}"
  target_key_id = aws_kms_key.kms-key.id
}
