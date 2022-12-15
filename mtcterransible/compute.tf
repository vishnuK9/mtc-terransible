resource "random_id" "mtc_node_id" {
  byte_length = 2
  count = var.main_instance_count
}

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "mtc_main" {
  count = var.main_instance_count
  instance_type = var.main_instance_type
  ami = data.aws_ami.server_ami.id
  # key_name = ""
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id = aws_subnet.mtc_public_subnet[count.index].id
  root_block_device {
    volume_size = var.main_vol_size
  }
  tags = {
    "name" = "mtc_main-${random_id.mtc_node_id[count.index].dec}"
  }
}