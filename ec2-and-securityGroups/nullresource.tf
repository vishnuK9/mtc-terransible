resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  connection {
    type = "ssh"
    host = "${module.ec2_public.public_ip}"
    user = "ec2-user"
    password = ""
    private_key = file("private-key/k8s.pem")
  }

  provisioner "file" {
    source = "private-key/k8s.pem"
    destination = "/tmp/k8s.pem"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo chmod 400 /tmp/k8s.pem"
    ]
  }

  provisioner "local-exec" {
    command = "echo vpc created on `date` and vpc id : ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
  }
}