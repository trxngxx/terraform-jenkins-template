variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "your_ip" {
  description = "Your IP address"  # Update public IP address
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "Dev"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "jenkins-artifacts-bucket"
}

variable "acl" {
  description = "Canned ACL to apply"
  type        = string
  default     = "private"
}
