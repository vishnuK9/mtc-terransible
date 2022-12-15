variable "vpc_cidr" {
  type = string
  description = "cidr value"
  default = "10.124.0.0/16"
}

variable "public_cidrs" {
  type = list(string)
  default = ["10.124.1.0/24","10.124.3.0/24"]
}