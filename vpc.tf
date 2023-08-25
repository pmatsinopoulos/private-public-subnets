resource "aws_vpc" "private_and_public_subnets" {
  cidr_block           = "172.18.0.0/27" # 32 IPs
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    "Name" = "${local.project}-vpc"
  }
}
