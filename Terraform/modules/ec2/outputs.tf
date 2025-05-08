output "ip_private_master" {
  value = aws_instance.master.private_ip
}

output "ip_public_master" {
  value = aws_instance.master.public_ip
}

output "ip_private_worker" {
  value = aws_instance.worker.private_ip
}

output "ip_public_worker" {
  value = aws_instance.worker.public_ip
}