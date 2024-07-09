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
  description = "Subnet ID"
  type        = string
}

variable "user_data" {
  description = "User data script"
  type        = string
}

variable "instance_name" {
  description = "Instance name tag"
  type        = string
}

variable "security_group" {
  description = "Security group"
  type        = string
}
