output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "subnet_id" {
  value = aws_subnet.custom_subnet.id
}
