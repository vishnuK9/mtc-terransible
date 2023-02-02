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

resource "aws_route" "private_routes" {
  route_table_id = aws_default_route_table.mtc_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.mtc_nat_gateway[0].id
  depends_on = [
    aws_nat_gateway.mtc_nat_gateway
  ]
}

# subnet creation based on number of subnet variables
resource "aws_subnet" "mtc_public_subnet" {
  count = length(local.azs)
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
  count = length(local.azs)
  vpc_id = aws_vpc.mtc_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.azs))
  map_public_ip_on_launch = false
  availability_zone = local.azs[count.index]
  tags = {
    Name = "mtc-private-${count.index + 1}"
  }
}

resource "aws_route_table_association" "mtc_public_association" {
  count = length(local.azs)
  subnet_id = aws_subnet.mtc_public_subnet[count.index].id
  route_table_id = aws_route_table.mtc_public_rt.id
}

resource "aws_eip" "mtc_nat_eip" {
  count = var.nat_gateway_needed ? 1 : 0
  vpc = true
}

resource "aws_nat_gateway" "mtc_nat_gateway" {
  count = var.nat_gateway_needed ? 1 : 0
  allocation_id = aws_eip.mtc_nat_eip[count.index].id
  subnet_id = aws_subnet.mtc_public_subnet[0].id

  tags = {
    Name = "mtc-nat-gateway"
  } 

  depends_on = [
    aws_internet_gateway.mtc_igw
  ]
}