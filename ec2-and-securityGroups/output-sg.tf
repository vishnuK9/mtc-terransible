output "public_bastion_sg_id" {
  description = "id of security group"
  value = module.public_bastion_sg.this_security_group_id
}

output "public_bastion_sg_group_vpc_id" {
  description = "vpc id"
  value = module.public_bastion_sg.this_security_group_vpc_id
}

output "public_bastion_sg_name" {
  description = "sg group name"
  value = module.public_bastion_sg.this_security_group_name
}

output "private_sg_group_id" {
  description = "private sg group if"
  value = module.private_sg.this_security_group_id
}

output "private_sg_group_vpc_id" {
  description = "the VPC id"
  value = module.private_sg.this_security_group_vpc_id
}

output "private_sg_group_name" {
  description = "name of the security group"
  value = module.private_sg.this_security_group_name
}