output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}

output "availability_zones" {
  value = data.aws_availability_zones.available
}

output "subnet_ids" {
  value = aws_subnet.mtc_public_subnet[*].id
}