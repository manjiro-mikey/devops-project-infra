# Create EC2
# Cluster
# =============================================== Master ===============================================
resource "aws_instance" "master" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id2
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group1]

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF

  tags = {
    Name    = "Master"
    Project = "Devops"
  }
}

resource "time_sleep" "wait_90_seconds_master" {
  depends_on      = [aws_instance.master]
  create_duration = "90s"
}

resource "null_resource" "sync_master" {
  depends_on = [time_sleep.wait_90_seconds_master]
  triggers = {
    always-update = timestamp()
  }

  connection {
    type = "ssh"
    # host = self.public_ip # Understand what is "self"
    host        = aws_instance.master.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/master.sh"
    destination = "/home/${var.user_ec2[1]}/master.sh"
  }

  provisioner "file" {
    source      = "./Executable_files/install_Master.sh"
    destination = "/home/${var.user_ec2[1]}/install_Master.sh"
  }

  provisioner "local-exec" {
    command     = "echo ${aws_instance.master.private_ip} >> creation-time-private-ip.yml"
    working_dir = "Output_files/"
    #on_failure = continue
  }

}

# =============================================== Worker ===============================================
resource "aws_instance" "worker" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id3
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group1]

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF

  tags = {
    Name    = "Worker"
    Project = "Devops"
  }
}

resource "time_sleep" "wait_90_seconds_worker" {
  depends_on      = [aws_instance.worker]
  create_duration = "90s"
}

resource "null_resource" "sync_worker" {
  depends_on = [time_sleep.wait_90_seconds_worker]
  triggers = {
    always-update = timestamp()
  }

  connection {
    type        = "ssh"
    host        = aws_instance.worker.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/worker.sh"
    destination = "/home/${var.user_ec2[1]}/worker.sh"
  }

  provisioner "local-exec" {
    command     = "echo ${aws_instance.worker.private_ip} >> creation-time-private-ip.yml"
    working_dir = "Output_files/"
    #on_failure = continue
  }

}

resource "aws_instance" "jenkins" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id3
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group1]

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF

  tags = {
    Name    = "Jenkins"
    Project = "Devops"
  }
  connection {
    type        = "ssh"
    host        = aws_instance.jenkins.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/install_Jenkins.sh"
    destination = "/home/${var.user_ec2[1]}/install_Jenkins.sh"
  }
}


