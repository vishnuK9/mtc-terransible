module "vpc" {
  source = "./vpc/"

  vpc_cidr = "10.123.0.0/16"
}

module "security-group" {
  source = "./security-groups/"
  vpc_id = module.vpc.vpc_id
}

