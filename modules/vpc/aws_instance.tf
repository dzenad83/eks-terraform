
#==================================================================================================
# EC2 NAT Gateway Instances
#==================================================================================================
resource "aws_instance" "ec2-nat-instance" {
  count                       = length(aws_subnet.public-subnets.*.id)
  ami                         = var.ec2-natgw-ami
  instance_type               = "t3.nano"
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  source_dest_check           = false
  key_name                    = var.ec2-key-pair-name
  vpc_security_group_ids      = [element(aws_security_group.ec2-nat-instance.*.id, count.index)]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    encrypted   = true
    kms_key_id  = var.kms-key
  }

  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-ec2-nat-instance-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
  volume_tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-ec2-nat-instance-%0d", count.index + 1)
    Backup      = "True"
    Environment = "${lower(terraform.workspace)}"
  }
}
