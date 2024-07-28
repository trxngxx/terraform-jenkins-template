variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "my-cluster"
}

variable "cluster_version" {
  description = "The version of the EKS cluster."
  type        = string
  default     = "1.21"
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster in."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID to create the EKS cluster in."
  type        = string
}
