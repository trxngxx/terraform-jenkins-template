provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  your_ip = var.your_ip
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  key_name       = var.key_name
  subnet_id      = module.vpc.subnet_id
  security_group = module.security_group.security_group_id
  instance_name  = "Jenkins-Server"
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = var.bucket_name
  acl          = var.acl
}

output "jenkins_instance_id" {
  value = module.ec2.instance_id
}

output "jenkins_public_ip" {
  value = module.ec2.public_ip
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.eks_cluster_name
  subnet_ids   = module.vpc.subnet_ids
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}