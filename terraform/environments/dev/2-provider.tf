provider "aws" {
  profile = "terraform-aicycle"
  region  = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46"
    }
  }

  # backend "s3" {
  #   key = "dev/terraform.tfstate"
  # }
}
