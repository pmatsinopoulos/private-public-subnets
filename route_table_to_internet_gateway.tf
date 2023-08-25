resource "aws_route_table" "to_internet_gateway" {
  vpc_id = aws_vpc.private_and_public_subnets.id

  tags = {
    "Name" = "access-to-internet"
  }
}

resource "aws_route" "to_internet_gateway" {
  route_table_id         = aws_route_table.to_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.private_and_public_subnets.id
}
