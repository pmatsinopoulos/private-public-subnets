resource "aws_key_pair" "private_public_subnets" {
  key_name   = local.project
  public_key = file("${path.module}/id_rsa.pub")
  tags = {
    "Name" = local.project
  }
}
