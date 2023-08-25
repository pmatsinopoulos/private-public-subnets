resource "aws_key_pair" "internal_to_vpc" {
  key_name   = "${local.project}-internal"
  public_key = file("${path.module}/id_rsa_internal.pub")
  tags = {
    "Name" = "${local.project}-internal"
  }
}
