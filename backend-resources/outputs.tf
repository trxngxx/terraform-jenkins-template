output "jenkins_instance_id" {
  description = "The ID of the Jenkins EC2 instance"
  value       = module.ec2.instance_id
}

output "jenkins_public_ip" {
  description = "The public IP address of the Jenkins EC2 instance"
  value       = module.ec2.public_ip
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket for Jenkins artifacts"
  value       = module.s3.bucket_name
}
