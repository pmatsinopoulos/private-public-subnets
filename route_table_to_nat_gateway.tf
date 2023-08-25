resource "aws_route_table" "to_nat_gateway" {
  vpc_id = aws_vpc.private_and_public_subnets.id

  tags = {
    "Name" = "access-to-nat-gateway"
  }
}

resource "aws_route" "to_nat_gateway" {
  route_table_id         = aws_route_table.to_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_and_public_subnets.id
}
