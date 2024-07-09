# Terraform AWS Jenkins Setup #
This repository contains Terraform code to set up an AWS infrastructure with Jenkins installed on an EC2 instance. The setup includes a VPC, subnet, security group, EC2 instance, and an S3 bucket for Jenkins artifacts.

## Prerequisites ##
 - Terraform installed
 - AWS credentials configured (e.g., via aws configure)
 - SSH key pair available in the specified AWS region

## Getting Started ##
1. Clone the repository

    git clone <repository-url>
cd backend-resources
2. Update variables
Edit the variables.tf file to update the default values for your AWS region, VPC CIDR, subnet CIDR, AMI ID, instance type, key name, and other necessary variables.

3. Initialize Terraform
Run the following command to initialize the Terraform configuration:

terraform init
4. Plan the deployment
Run the following command to see the execution plan:

terraform plan
5. Apply the deployment
Run the following command to apply the configuration:

terraform apply
6. Access Jenkins
Once the deployment is complete, you can access Jenkins using the public IP of the EC2 instance. The public IP will be displayed in the output.

echo "Jenkins Public IP: $(terraform output jenkins_public_ip)"

## Open your browser and navigate to http://<jenkins_public_ip>:8080 to access Jenkins. ##

### Module Details ###
VPC Module
Creates a VPC and a subnet.

modules/vpc/main.tf

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.this.id
}
### Security Group Module ###
Creates a security group with rules for SSH and HTTP access.

modules/security_group/main.tf

resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-sg"
  }
}

output "security_group_id" {
  value = aws_security_group.jenkins_sg.id
}

### EC2 Module ###
Creates an EC2 instance with Jenkins installed.

modules/ec2/main.tf

resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  user_data     = file("${path.module}/user_data.sh")

  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}
modules/ec2/user_data.sh

#!/bin/bash
yum update -y
yum install -y java-11-openjdk-devel
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
systemctl start jenkins
systemctl enable jenkins

### S3 Module ###
Creates an S3 bucket for Jenkins artifacts.

modules/s3/main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
## Cleanup ##
To destroy all resources created by this Terraform configuration, run:

terraform destroy

## License ##
This project is licensed under the MIT License.