variable "instance_type" {
  description = "instance type"
  type = string
  default = "t2.micro"
}

variable "instance_keypair" {
  description = "instance key pair"
  type = string
  default = "k8s"
}