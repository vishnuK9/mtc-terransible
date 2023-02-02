module "vpc" {
  source = "./vpc/"

  vpc_cidr = "10.123.0.0/16"
}