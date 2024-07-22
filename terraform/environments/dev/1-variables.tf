variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "ecr-role" {
  type    = string
  default = "terraform-read-ecr"
}

variable "tag_name" {
  type    = string
  default = "aicycle-backup"
}

locals {
  private_key_path = "/home/aicycle/aicycle-automation-recovery.pem"
}

variable "vpc_id" {
  description = "vpc id for the resources"
  default     = "vpc-0c4e68b3e11626944"
}

variable "nginx" {
  default = {
    instance_id = "i-0131db4c18d35cb1d"
    private_ip  = "10.0.8.137"
    public_ip   = "52.74.216.168"
  }
}

variable "private_subnet_id" {
  description = "private subnet id for the resources"
  default     = "subnet-06f52e50f28f5ad46"
}

// K8S instance

variable "ec2_common" {
  default = {
    ami      = "ami-003c463c8207b4dfa"
    key_name = "aicycle-automation-recovery"
  }
}

variable "k8s" {
  default = {
    master = {
      # instance_type = "t2.micro"
      # vol_size      = 20
      # vol_type      = "gp2"
      instance_type = "t3.large"
      vol_size      = 100
      vol_type      = "gp3"
    }

    be_worker = {
      # instance_type = "t2.micro"
      # vol_size      = 20
      # vol_type      = "gp3"
      num           = 3
      instance_type = "t3.medium"
      vol_size      = 60
      vol_type      = "gp3"
    }
  }
}
