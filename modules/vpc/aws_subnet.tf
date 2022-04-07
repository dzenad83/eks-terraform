#==================================================================================================
# Public Subnets
#==================================================================================================
resource "aws_subnet" "public-subnets" {
  count                = var.number-of-azs
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = element(split(",", var.public-subnets-cidrs), count.index)
  availability_zone_id = element(split(",", var.az-ids), count.index)
  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-pub-subnet-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
}
#==================================================================================================
# Private Subnets
#==================================================================================================
resource "aws_subnet" "private-subnets" {
  count                = var.number-of-azs
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = element(split(",", var.private-subnets-cidrs), count.index)
  availability_zone_id = element(split(",", var.az-ids), count.index)
  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-priv-subnet-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
}
