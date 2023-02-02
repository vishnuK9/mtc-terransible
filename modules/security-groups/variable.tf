variable "vpc_id" {
}

variable "access_ip" {
  type = list(string)
  default = ["0.0.0.0/0"]
}