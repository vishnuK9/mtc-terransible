module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name = "${var.environment}-bastion-host"
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  tags = local.common_tags

  provisioner "local-exec" {
    command = "echo vpc created on `date` and vpc id : ${data.terraform_remote_state.vpc.outputs.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
  }

  ## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }    
}