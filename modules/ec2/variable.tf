variable "main_instance_type" {
  type = string
  default = "t2.micro"
}

variable "main_vol_size" {
  type = number
  default = 8 
}

variable "vpc_security_group_ids" {
  type = string
}

variable "subnet_id" {
}