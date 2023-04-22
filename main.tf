resource "aws_instance" "Test-server" {
  ami           = "ami-007855ac798b5175e" 
  instance_type = "t2.medium" 
  availability_zone      = "us-east-1a"
  resource "aws_security_group_rule" "my_rule" {
  security_group_id = aws_security_group.my_existing_sg.id
  # ... other rule configuration ...
}
resource "aws_security_group" "my_new_sg" {
  name        = "my_new_sg"
  # ... other security group configuration ...
}
  //vpc_security_group_ids = ["sg-011bfcf57c8aee9ff"]
  key_name = "kubekey.pem"
  tags = {
    name = "kubernetes_instance"
  }
  
   provisioner "remote-exec" {
     inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo chmod +x /home/ubuntu/minikube-linux-amd64",
      "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
      "sudo chmod +x /home/ubuntu/kubectl",
      "sudo cp kubectl /usr/local/bin/kubectl",
      "sudo usermod -aG docker ubuntu"
       ]
     connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("./kubekey.pem")
    }
  }
}
  //connection {
    //type     = "ssh"
    //user     = "ubuntu"
    //private_key = file("kubekey.pem")
    // host     = self.public_ip
    //host = aws_instance.instance.public_ip
   
 // }
 
   // inline = [ "echo 'wait to start instance' "]
  //}
  //tags = {
    //Name = "test-server"
  //}
  //provisioner "local-exec" {
        //command = " echo ${aws_instance.test-server.public_ip} > inventory "
  //}
   //provisioner "remote-exec" {
     //inline = [
            //   "sudo apt upadte -y",
              // "sudo apt install docker.io -y",
               //"sudo snap install microk8s --clasic",
               //"sudo sleep 30",
               //"sudo microk8s status",
               //"sudo microk8s kubectl create deployment medicure-deploy --image=shankerchauhan/projects:healthcare1",
               //"sudo microk8s kubectl expose deployment medicure-deploy --port=8082 --type=NodePort",
               //"sudo microk8s kubectl get svc",
               //"sudo echo public IP Address of the Instance",
               //"sudo curl http://checkip.amazonaws.com",
       //]
   //} 
//}
