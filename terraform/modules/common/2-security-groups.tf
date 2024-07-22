resource "aws_security_group" "aicycle-k8s-private-sg-1" {
  name        = "security-groups-${var.environment}"
  description = "Security group k8s."
  vpc_id      = var.vpc_id
  tags = {
    Name = "security-group-1-${var.environment}"
    ENV  = format("%s-%s", var.tag_name, var.environment)
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.nginx.private_ip}/32"]
  }

  // allow ssh from SETA network
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["118.70.190.230/32"]
  }

  // allow ssh from SETA network
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["113.190.252.197/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}