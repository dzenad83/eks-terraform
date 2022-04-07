#==================================================================================================
# Internet Gateway
#==================================================================================================
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${lower(terraform.workspace)}-${lower(var.project-name)}-igw-vpc"
    Environment = "${lower(terraform.workspace)}"
  }
}
