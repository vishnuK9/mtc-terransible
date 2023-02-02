module "vpc" {
  source = "./vpc/"

  vpc_cidr = "10.123.0.0/16"
  nat_gateway_needed = true
}

# module "security-group" {
#  source = "./security-groups/"
#  vpc_id = module.vpc.vpc_id
# }

# module "ec2" {
#  source = "./ec2/"
#  vpc_security_group_ids = module.security-group.security_group_id
#  subnet_id = module.vpc.subnet_ids
# }