resource "aws_instance" "jenkins_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  user_data = var.user_data

  tags = {
    Name = var.instance_name
  }

  security_groups = [var.security_group]
}
