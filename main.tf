resource "aws_instance" "test-server" {
  ami           = "ami-07d3a50bd29811cd1" 
  instance_type = "t2.micro" 
  key_name = "frstkey"
  vpc_security_group_ids= ["sg-0347106857582df29"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./frstkey.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/HealthCare/ansible-playbook.yml "
  } 
}
