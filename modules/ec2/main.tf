resource "aws_instance" "mtc-main" {
  instance_type = var.main_instance_type
  ami = data.aws_ami.server_ami.id
  # key_name = 
  vpc_security_group_ids = [ var.vpc_security_group_ids ]
  subnet_id = var.subnet_ids[0]
  root_block_device {
    volume_size = var.main_vol_size
  }

  tags = {
    Name = "mtc-main"
  }
}