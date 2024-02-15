terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

variable "vpc_id" {}
variable "cidr" {}
variable "ssh_key" {}

resource "aws_security_group" "sg_ssh_only" {
  name = "sg_ssh_only"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "HW4"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name = "name"
    values = ["debian-12-amd64-*"]
  }

  owners = ["136693071363"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.debian.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_ssh_only.id]
  key_name = var.ssh_key

  tags = {
    Name = "debian_server"
  }
}

output "hostid" {
  value = aws_instance.server.*.public_dns
}