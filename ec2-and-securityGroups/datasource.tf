data "aws_ami" "amzlinux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    value = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name = "root-device-type"
    value = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    value = ["hvm"]
  }
  filter {
    name = "architecture"
    value = ["x86_64"]
  }
}
