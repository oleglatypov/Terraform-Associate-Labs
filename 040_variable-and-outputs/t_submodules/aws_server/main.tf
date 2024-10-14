terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}



variable "instance_type" {
  type = string
  description = "The size of the instance."
  #sensitive = true
  validation {
    condition     = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance."
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  ami = "ami-0fff1b9a61dec8a5f"
}

resource "aws_instance" "my_server" {
  ami           = data.aws_ami.ubuntu.id
#   ami           = local.ami
  instance_type = var.instance_type
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
