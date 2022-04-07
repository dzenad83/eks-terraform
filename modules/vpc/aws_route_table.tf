#==================================================================================================
# Public Subnets Route Tables
#==================================================================================================
resource "aws_route_table" "public-subnets-route-tables" {
  count  = var.number-of-azs
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id

  }
  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-rtb-pub-subnet-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
}
#==================================================================================================
# Private Subnets Route Tables
#==================================================================================================
resource "aws_route_table" "private-subnets-route-tables" {
  count  = var.number-of-azs
  vpc_id = aws_vpc.vpc.id
  route = [{
    carrier_gateway_id         = null
    cidr_block                 = "0.0.0.0/0"
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = null
    instance_id                = element(aws_instance.ec2-nat-instance.*.id, count.index)
    ipv6_cidr_block            = null
    local_gateway_id           = null
    nat_gateway_id             = null
    network_interface_id       = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]
  tags = {
    Name        = format("${lower(terraform.workspace)}-${lower(var.project-name)}-rtb-prv-subnet-%0d", count.index + 1)
    Environment = "${lower(terraform.workspace)}"
  }
}
