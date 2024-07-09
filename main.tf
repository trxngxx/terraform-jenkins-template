provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  your_ip = "your-ip-address/32"     #update this IP address
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = "ami-0c55b159cbfafe1f0"     #update this AMI
  instance_type  = "t2.micro"  
  key_name       = "your-key-name"             #update this keypair
  subnet_id      = module.vpc.subnet_id
  user_data      = <<-EOF
                    #!/bin/bash
                    yum update -y
                    yum install -y java-11-openjdk-devel
                    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
                    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                    yum install -y jenkins
                    systemctl start jenkins
                    systemctl enable jenkins
                    EOF
  instance_name  = "Jenkins-Server"
  security_group = module.security_group.security_group_id
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = "your-jenkins-artifacts-bucket"
  environment  = "Dev"
}

output "jenkins_instance_id" {
  value = module.ec2.instance_id
}

output "jenkins_public_ip" {
  value = module.ec2.public_ip
}
