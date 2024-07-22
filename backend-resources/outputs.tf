output "jenkins_instance_id" {
  description = "The ID of the Jenkins instance"
  value       = module.ec2.instance_id
}

output "jenkins_public_ip" {
  description = "The public IP of the Jenkins instance"
  value       = module.ec2.public_ip
}
