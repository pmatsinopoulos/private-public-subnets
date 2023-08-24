resource "aws_vpc" "sms" {
  cidr_block           = "172.18.0.0/28"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    "Name" = "${local.project}-vpc"
  }
}
