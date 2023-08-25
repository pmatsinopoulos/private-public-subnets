resource "aws_eip" "nat_gateway" {
  depends_on = [aws_internet_gateway.private_and_public_subnets]
}

resource "aws_nat_gateway" "private_and_public_subnets" {
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_gateway.id
  subnet_id         = aws_subnet.subnet_2.id # public subnet

  tags = {
    Name = local.project
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.private_and_public_subnets]
}
