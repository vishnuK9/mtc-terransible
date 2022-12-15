data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "mtc_main" {
  instance_type = var.main_instance_type
  ami = data.aws_ami.server_ami.id
  # key_name = ""
  vpc_security_group_id = [aws_security_group.mtc_sg.id]
  subnet_id = aws_subnet.mtc_public_subnet[0].id
  root_block_device {
    volume_size = var.main_vol_size
  }
  tags = {
    "name" = "mtc_main"
  }

}