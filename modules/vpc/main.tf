# Random Reosurce
locals {
  azs = data.aws_availability_zones.available.names
}

resource "random_id" "random" {
  byte_length = 2
}

# VPC creation
resource "aws_vpc" "mtc_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "mtc-vpc-${random_id.random.dec}"
  }
  # lifecycle creates a resource before destroying it
  lifecycle {
    create_before_destroy = true
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "mtc_igw" {
  vpc_id = aws_vpc.mtc_vpc.id
  
  tags = {
    Name = "mtc_iqw-${random_id.random.dec}"
  }
}

# route table creation
resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "mtc-public"
  }
}
# adding routes to public route table
resource "aws_route" "default_route" {
  # need a depends on meta 
  route_table_id = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.mtc_igw.id
}

# importing the default route table and treating it private  
resource "aws_default_route_table" "mtc_private" {
  default_route_table_id = aws_vpc.mtc_vpc.default_route_table_id

  tags = {
    Name = "mtc-private"
  }
}

# subnet creation based on number of subnet variables
resource "aws_subnet" "mtc_public_subnet" {
  count = length(var.public_cidrs)
  vpc_id = aws_vpc.mtc_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = local.azs[count.index]

  tags = {
    Name = "mtc-public-${count.index + 1}"
  }
}

# subnet creation based on number of subnet variables
resource "aws_subnet" "mtc-private" {
  count = length(var.private_cidrs)
  vpc_id = aws_vpc.mtc_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.azs))
  map_public_ip_on_launch = false
  availability_zone = local.azs[count.index]
  tags = {
    Name = "mtc-private-${count.index + 1}"
  }
}