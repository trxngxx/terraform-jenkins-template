variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "Canned ACL to apply"
  type        = string
  default     = "private"
}
