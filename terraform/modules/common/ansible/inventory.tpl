[master]
master ansible_host=${master_private_ip} ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -i ${ssh_private_key} ubuntu@${nginx_public_ip}" -o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${ssh_private_key}

[workers]
%{ for worker in workers_private_ips ~}
worker-${worker.index} ansible_host=${worker.ip} ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -i ${ssh_private_key} ubuntu@${nginx_public_ip}" -o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${ssh_private_key}
%{ endfor ~}
