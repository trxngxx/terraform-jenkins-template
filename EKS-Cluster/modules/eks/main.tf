module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version 
  vpc_id          = var.vpc_id
}

output "cluster_id" {
  value = module.eks.cluster_id
}
