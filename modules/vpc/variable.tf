variable "vpc_cidr" {
  description = "cidr block for vpc"
  type = string
  default = "10.123.0.0/16"
}

variable "public_cidrs" {
  type = list(string)
  default = [ "10.123.1.0/24","10.123.3.0/24"]
}

variable "" {
  
}