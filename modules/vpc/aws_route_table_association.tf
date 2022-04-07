#==================================================================================================
# Public Subnets Associations
#==================================================================================================
resource "aws_route_table_association" "public-subnets-association" {
  count          = var.number-of-azs
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public-subnets-route-tables.*.id, count.index)
}
#==================================================================================================
# Private Subnets Associations
#==================================================================================================
resource "aws_route_table_association" "private-subnets-association" {
  count          = var.number-of-azs
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private-subnets-route-tables.*.id, count.index)
}
