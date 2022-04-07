#==================================================================================================
# EC2 NAT Instances Security Groups
#==================================================================================================
resource "aws_security_group" "ec2-nat-instance" {
  count  = length(aws_subnet.public-subnets.*.id)
  name   = format("${lower(terraform.workspace)}-${lower(var.project-name)}-ec2-nat-instance-%0d", count.index + 1)
  vpc_id = aws_vpc.vpc.id
  ingress = [{
    cidr_blocks = [
      aws_vpc.vpc.cidr_block
    ]
    description      = "HTTP"
    from_port        = 80
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    protocol         = "tcp"
    security_groups  = null
    self             = null
    to_port          = 80
    },
    {
      cidr_blocks = [
        aws_vpc.vpc.cidr_block
      ]
      description      = "HTTPS"
      from_port        = 443
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      self             = null
      to_port          = 443
  }]
  egress = [{
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    description      = "HTTP"
    from_port        = 80
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    protocol         = "tcp"
    security_groups  = null
    self             = null
    to_port          = 80
    },
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      description      = "HTTPS"
      from_port        = 443
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      self             = null
      to_port          = 443
  }]
  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-ec2-nat-instance-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
}
