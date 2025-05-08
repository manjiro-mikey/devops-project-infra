#Create IAM
module "iam" {
  source = "./modules/iam"
}

# Create S3
module "s3" {
  source = "./modules/s3"
}

# Create key-pair for EC2 instances
resource "random_id" "id" {
  byte_length = 8
}

resource "aws_key_pair" "TF_key" {
  # count      = var.create_key_pair ? 1 : 0
  key_name   = (var.key_name != "" ? var.key_name : random_id.id.hex)
  public_key = tls_private_key.rsa.public_key_openssh

  tags = {
    Name    = "trourest-bastion"
    Project = "Devops"
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
  # Then chmod 400
}

module "vpc" {
  source   = "./modules/vpc"
  project  = var.project
  region   = var.aws_region
  name     = var.name
  vpc_cidr = var.vpc_cidr
  sbit     = var.sbit
}

locals {
  subnets = {
    public1 = module.vpc.public1_subnet,
    public2 = module.vpc.public2_subnet,
    public3 = module.vpc.public3_subnet,
    // Add more subnets if needed
  }
  security = {
    security1 = module.vpc.aws_route_table_bastion
    security2 = module.vpc.aws_instance_table_webserver
    security3 = module.vpc.aws_instance_table_dbserver
  }
}

locals {
  private_key_content = tls_private_key.rsa.private_key_pem
}

module "ec2" {
  source = "./modules/ec2"

  key_name            = aws_key_pair.TF_key.key_name
  instance_type       = var.instance_type
  ami_type            = var.ami_type
  private_key_content = local.private_key_content

  security_group1 = local.security["security1"]
  security_group2 = local.security["security2"]
  security_group3 = local.security["security3"]

  sub_id1 = local.subnets["public1"]
  sub_id2 = local.subnets["public2"]
  sub_id3 = local.subnets["public3"]
}
