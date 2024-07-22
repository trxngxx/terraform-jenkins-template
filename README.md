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

### Security Group Module ###
Creates a security group with rules for SSH and HTTP access.

modules/security_group/main.tf

### EC2 Module ###
Creates an EC2 instance with Jenkins installed.

modules/ec2/main.tf

modules/ec2/user_data.sh

### S3 Module ###
Creates an S3 bucket for Jenkins artifacts.

modules/s3/main.tf


## Cleanup ##
To destroy all resources created by this Terraform configuration, run:

terraform destroy

## License ##
This project is licensed under the MIT License.
