resource "aws_security_group" "mtc_sg" {
  name = "public_sg"
  description = "security groups for public instances"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_all" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = var.access_ip   
  security_group_id = aws_security_group.mtc_sg.id
}

resource "aws_security_group_rule" "egress_all" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mtc_sg.id
}