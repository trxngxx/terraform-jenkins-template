resource "null_resource" "wait_for_instances" {
  depends_on = [null_resource.start_nginx_instances]
  provisioner "local-exec" {
    command = "echo Instances are ready"
  }

  triggers = {
    instance_ids = join(",", aws_instance.k8s_be_worker1.*.id, [aws_instance.k8s_master1.id])
  }
}

resource "null_resource" "run_ansible_playbooks" {
  depends_on = [null_resource.wait_for_instances, local_file.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOL
for playbook in ${path.module}/ansible/*.yml; do
  ansible-playbook -i ${path.module}/ansible/inventory.ini $playbook 
done
EOL
  }
}



