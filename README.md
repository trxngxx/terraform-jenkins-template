# AICYCLE-INFRA

## Introduction

This project uses Terraform to provision cloud resources and Ansible to automate the setup and configuration of Kubernetes. Additional addons and Helm packages required for the project are deployed automatically.

## Requirements

- Terraform
- Ansible
- Python with `hvac` library (for working with Vault)
- SSH access to servers

## Installation and Deployment

After initializing resources with Terraform, Ansible will automatically run with sequentially numbered tasks.
The vault.yml file alone requires a vault password to decrypt. Contact developer for availability.

```bash
##Example of /etc/ansible/hosts
[all]
192.168.80.245
192.168.80.186
192.168.80.195
192.168.80.150

[master]
master ansible_host=192.168.80.245

[workers]
worker1 ansible_host=192.168.80.186
worker2 ansible_host=192.168.80.196
worker3 ansible_host=192.168.80.195
worker4 ansible_host=192.168.80.150

[nginx-server]
#nginx ansible_host=192.168.80.194
worker4 ansible_host=192.168.80.150
nginx-worker ansible_host=192.168.80.150
=======

>>>>>>> 1fe74a30e56d7d34ae99583e3be87399bed93d71
=======
```

# Terraform AWS Jenkins Setup #
This repository contains Terraform code to set up an AWS infrastructure with Jenkins installed on an EC2 instance. The setup includes a VPC, subnet, security group, EC2 instance, and an S3 bucket for Jenkins artifacts.

## Prerequisites ##
 - Terraform installed
 - AWS credentials configured (e.g., via aws configure)
 - SSH key pair available in the specified AWS region

## Getting Started ##
1. Clone the repository
```bash
    git clone <repository-url>
    cd backend-resources
```

2. Update variables
Edit the variables.tf file to update the default values for your AWS region, VPC CIDR, subnet CIDR, AMI ID, instance type, key name, and other necessary variables.

3. Initialize Terraform
Run the following command to initialize the Terraform configuration:

```bash
terraform init
```

4. Plan the deployment
Run the following command to see the execution plan:

```bash
terraform plan
```

5. Apply the deployment
Run the following command to apply the configuration:

```bash
terraform apply
```

6. Access Jenkins
Once the deployment is complete, you can access Jenkins using the public IP of the EC2 instance. The public IP will be displayed in the output.

```bash
echo "Jenkins Public IP: $(terraform output jenkins_public_ip)"
```

## Open your browser and navigate to http://<jenkins_public_ip>:8080 to access Jenkins. ##

### Module Details ###
VPC Module
Creates a VPC and a subnet.

```bash
modules/vpc/main.tf
```

### Security Group Module ###
Creates a security group with rules for SSH and HTTP access.

```bash
modules/security_group/main.tf
```

### EC2 Module ###
Creates an EC2 instance with Jenkins installed.

```bash
modules/ec2/main.tf
modules/ec2/user_data.sh
```

### S3 Module ###
Creates an S3 bucket for Jenkins artifacts.

```bash
modules/s3/main.tf
```

## Cleanup ##
To destroy all resources created by this Terraform configuration, run:

```bash
terraform destroy
```

## License ##
This project is licensed under the MIT License.
>>>>>>> terraform-jenkins-template/k8s-cluster
