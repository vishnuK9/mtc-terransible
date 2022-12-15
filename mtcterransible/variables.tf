variable "vpc_cidr" {
  type = string
  description = "cidr value"
  default = "10.124.0.0/16"
}

variable "access_ip" {
  type = list(string)
  default = ["0.0.0.0/0"]
}