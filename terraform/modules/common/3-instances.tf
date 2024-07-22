data "aws_instance" "nginx_instance_id" {
  instance_id = var.nginx.instance_id # Replace with your instance ID
}

resource "aws_instance" "k8s_ip" {
  depends_on    = [null_resource.start_nginx_instances]
  ami           = var.ec2_common.ami
  instance_type = "t2.micro"
  # private_ip                  = var.instance.private_ip
  associate_public_ip_address = false
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.aicycle-k8s-private-sg-1.id]
  tags = {
    Name = "ec2-instance-${var.environment}"
    ENV  = format("%s-%s", var.tag_name, var.environment)
  }

  root_block_device {
    volume_size = 30
    volume_type = var.k8s.be_worker.vol_type
    encrypted   = false
  }
  key_name = var.ec2_common.key_name
  provisioner "file" {
    source      = "${path.module}/ansible/update_ssh_config.sh"
    destination = "/home/ubuntu/update_ssh_config.sh"

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/update_ssh_config.sh",
      "sudo /home/ubuntu/update_ssh_config.sh"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }
}


resource "aws_instance" "k8s_master1" {
  depends_on    = [null_resource.start_nginx_instances]
  ami           = var.ec2_common.ami
  instance_type = var.k8s.master.instance_type
  # private_ip                  = var.instance.private_ip
  associate_public_ip_address = false
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.aicycle-k8s-private-sg-1.id]
  tags = {
    Name = "master-1-${var.environment}"
    ENV  = format("%s-%s", var.tag_name, var.environment)
  }
  root_block_device {
    volume_size = var.k8s.master.vol_size
    volume_type = var.k8s.master.vol_type
    encrypted   = false
  }
  key_name = var.ec2_common.key_name

  provisioner "file" {
    source      = "${path.module}/ansible/update_ssh_config.sh"
    destination = "/home/ubuntu/update_ssh_config.sh"

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/update_ssh_config.sh",
      "sudo /home/ubuntu/update_ssh_config.sh"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }
  iam_instance_profile = var.ecr-role
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname master
              EOF
}

resource "aws_instance" "k8s_worker1" {
  depends_on    = [null_resource.start_nginx_instances]
  count         = var.k8s.be_worker.num
  ami           = var.ec2_common.ami
  instance_type = var.k8s.be_worker.instance_type
  # private_ip                  = var.instance.private_ip
  associate_public_ip_address = false
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.aicycle-k8s-private-sg-1.id]
  tags = {
    Name = "k8s_worker-1-${var.environment}"
    ENV  = format("%s-%s", var.tag_name, var.environment)
  }
  root_block_device {
    volume_size = var.k8s.be_worker.vol_size
    volume_type = var.k8s.be_worker.vol_type
    encrypted   = false
  }
  key_name = var.ec2_common.key_name
  provisioner "file" {
    source      = "${path.module}/ansible/update_ssh_config.sh"
    destination = "/home/ubuntu/update_ssh_config.sh"

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/update_ssh_config.sh",
      "sudo /home/ubuntu/update_ssh_config.sh"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.nginx.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.private_key_path)
    }
  }

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname worker-${count.index + 1}
              EOF
}

resource "local_file" "ansible_inventory" {
  depends_on = [null_resource.start_nginx_instances]
  content = templatefile("${path.module}/ansible/inventory.tpl", {
    master_private_ip   = aws_instance.k8s_master1.private_ip
    ssh_private_key     = var.private_key_path
    nginx_public_ip     = var.nginx.public_ip
    workerip_private_ip = aws_instance.k8s_ip.private_ip
    workers_private_ips = [
      for idx, instance in aws_instance.k8s_be_worker1 :
      { index = idx, ip = instance.private_ip }
    ]
  })
  filename = "${path.module}/ansible/inventory.ini"
}

resource "local_file" "worker_ip_ansible_task" {
  depends_on = [aws_instance.k8s_ip]
  content = templatefile("${path.module}/ansible/worker-ip-task.tpl", {
    worker_ip   = aws_instance.k8s_ip.private_ip
  })
  filename = "${path.module}/ansible/5-worker-ip-task.yml"
}

output "master_private_ip" {
  value = aws_instance.k8s_master1.private_ip
}

output "workers_private_ips" {
  value = [for instance in aws_instance.k8s_be_worker1 : instance.private_ip]
}

output "k8s_ip" {
  value = aws_instance.k8s_ip.private_ip
}
