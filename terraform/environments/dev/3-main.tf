module "common" {
  source            = "../../modules/common"
  environment       = var.environment
  region            = var.region
  tag_name          = var.tag_name
  ec2_common        = var.ec2_common
  k8s               = var.k8s
  private_subnet_id = var.private_subnet_id
  nginx             = var.nginx
  vpc_id            = var.vpc_id
  private_key_path  = local.private_key_path
  ecr-role          = var.ecr-role
}
