module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name = "${var.environment}-vm"
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  
  vpc_security_group_ids = [ module.public_bastion_sg.this_security_group_id]
  instance_count = 3
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.private_subnets[0],
    data.terraform_remote_state.vpc.outputs.private_subnets[1],
  ]
  tags = local.common_tags
}