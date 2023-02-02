resource "random_id" "random" {
  byte_length = 2
}

resource "aws_vpc" "mtc_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "mtc-vpc-${random_id.random.dec}"
  }
}

resource "aws_internet_gateway" "mtc_igw" {
  vpc_id = aws_vpc.mtc_vpc.id
  
  tags = {
    Name = "mtc_iqw-${random_id.random.dec}"
  }
}