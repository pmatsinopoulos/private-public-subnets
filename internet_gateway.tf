resource "aws_internet_gateway" "private_and_public_subnets" {
  vpc_id = aws_vpc.private_and_public_subnets.id
  tags = {
    "Name" = "igw"
  }
}
