variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be deployed"
  type        = string
}

variable "security_group" {
  description = "The ID of the security group to assign to the instance"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "user_data" {
  description = "The user data script to use for instance initialization"
  type        = string
}
