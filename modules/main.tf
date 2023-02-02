module "vpc" {
  source = "./vpc/"

  vpc_cidr = "10.124.0.0/16"
}