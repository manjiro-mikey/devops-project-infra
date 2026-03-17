# Input Variables
# =================================== Using for EC2-instances ===================================
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-01938df366ac2d954" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-09-19
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}

# For VPC
variable "project" {}

variable "vpc_cidr" {}

variable "sbit" {}

variable "name" {}

# For EC2 
variable "key_name" {}

variable "region" {}

variable "instance_type" {}

variable "ami_type" {
  description = "Optional AMI ID override. If null, EC2 module auto-selects Ubuntu 22.04 LTS for the current region."
  type        = string
  default     = null
}

# variable "create_key_pair" {}