provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source  = "./modules/eks"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
}

module "s3" {
  source = "./modules/s3"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "aws_region" {
  value = var.aws_region
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = <<EOT
      export AWS_REGION=$(terraform output -raw aws_region)
      export EKS_CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
      ./scripts/run_ansible.sh $${AWS_REGION} $${EKS_CLUSTER_NAME}
    EOT
  }
}
