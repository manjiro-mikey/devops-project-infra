variable "key_name" {
  type = string
}

# variable "project" {}

# variable "name" {}

# variable "project" {}

variable "security_group1" {}

variable "security_group2" {}

variable "security_group3" {}

variable "sub_id1" {}

variable "sub_id2" {}

variable "sub_id3" {}

variable "private_key_content" {}

variable "user_ec2" {
  description = "User of EC2 instances"
  type        = list(string)
  default     = ["ec2-user", "ubuntu"]
}

variable "instance_type" {
  default = "t2-micro"
  type    = string
}

variable "ami_type" {
  description = "Optional AMI ID override. If null, auto-select Ubuntu 22.04 LTS for the current region."
  type        = string
  default     = null
}

# variable "create_key_pair" {}