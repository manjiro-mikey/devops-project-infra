[master]
${master_public_ip}

[worker1]
${worker_public_ip}

[jenkins]
${jenkins_public_ip}

[master:vars]
ansible_ssh_private_key_file=./storage/ec2-key.pem

[worker1:vars]
ansible_ssh_private_key_file=./storage/ec2-key.pem

[jenkins:vars]
ansible_ssh_private_key_file=./storage/ec2-key.pem

[all:vars]
ansible_python_interpreter=/usr/bin/python3
