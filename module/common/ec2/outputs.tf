output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.jenkins.id
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.jenkins.public_ip
}
