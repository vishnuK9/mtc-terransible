resource "aws_vpc" "main" {
  cidr_block = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    name = "mtc_vpc"
  }
}