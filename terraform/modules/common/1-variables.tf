variable "region" {
  description = "region  where the resources will be created"
}

# data "terraform_remote_state" "source" {
#   backend = "s3"
#   config = {
#     bucket = "my-terraform-state-bucket"
#     key    = "source/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

variable "environment" {
  description = "environment where the resources will be created"
}

variable "tag_name" {
  description = "tag name for the resources"
}

variable "private_key_path" {
  description = " private key path for the resources"
}

variable "ecr-role" {
  description = "ecr role for the resources"
}

variable "vpc_id" {
  description = " vpc id for the resources"
}

variable "nginx" {
  description = "nginx instance"
}

variable "private_subnet_id" {
  description = "private subnet id for the resources"
}
// K8S instance

variable "ec2_common" {
  description = "ami and key name for ec2 instances"
  default = {
    ami      = ""
    key_name = ""
  }
}

variable "bastion" {
  description = "bastion instance config"
  default = {
    instance_type = ""
    vol_size      = 0
    vol_type      = ""
  }
}

variable "k8s" {
  description = "k8s config"
  default = {
    master = {
      instance_type = ""
      vol_size      = 0
      vol_type      = ""
    }

    be_worker = {
      instance_type = ""
      vol_size      = 0
      vol_type      = ""
      num           = 0
    }

    monitor_worker = {
      instance_type = ""
      vol_size      = 0
      vol_type      = ""
      num           = 0
    }
  }
}
