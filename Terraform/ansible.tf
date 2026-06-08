locals {
  ansible_hosts_path = "${path.module}/../Ansible/hosts"
  ansible_vars_path  = "${path.module}/../Ansible/vars/create-time-private-ip.yml"
  ansible_key_path   = "${path.module}/../Ansible/storage/ec2-key.pem"

  # Must match placeholder IPs in Executable_files/master.sh and worker.sh.
  # Terraform re-uploads those scripts on each apply, so Ansible lineinfile
  # searches for these values before replacing with live private IPs.
  master_private_ip_old = "10.0.1.214"
  worker_private_ip_old = "10.0.2.58"
}

resource "local_file" "ansible_hosts" {
  content = templatefile("${path.module}/templates/ansible_hosts.tpl", {
    master_public_ip  = module.ec2.ip_public_master
    worker_public_ip  = module.ec2.ip_public_worker
    jenkins_public_ip = module.ec2.ip_public_jenkins
  })
  filename = local.ansible_hosts_path
}

resource "local_file" "ansible_private_ips" {
  content = templatefile("${path.module}/templates/ansible_private_ips.yml.tpl", {
    master_private_ip     = module.ec2.ip_private_master
    worker_private_ip     = module.ec2.ip_private_worker
    master_private_ip_old = local.master_private_ip_old
    worker_private_ip_old = local.worker_private_ip_old
  })
  filename = local.ansible_vars_path
}

resource "local_file" "ansible_ssh_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = local.ansible_key_path
  file_permission = "0400"
}
