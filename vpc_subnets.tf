resource "aws_subnet" "subnet_1" {
  availability_zone = "eu-west-1a"
  cidr_block        = "172.18.0.0/28"
  tags = {
    "Name" = "private-subnet-1"
  }

  vpc_id = aws_vpc.private_and_public_subnets.id
}

resource "aws_subnet" "subnet_2" {
  availability_zone = "eu-west-1b"
  cidr_block        = "172.18.0.16/28"
  tags = {
    "Name" = "public-subnet-2"
  }

  vpc_id = aws_vpc.private_and_public_subnets.id
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.to_internet_gateway.id
}
