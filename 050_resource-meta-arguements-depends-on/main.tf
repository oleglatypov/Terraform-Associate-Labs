terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  profile = "aws-oleg-terraform"
  region  = "us-east-1"
}

# resource "aws_s3_bucket" "t_bucket" {
#   bucket = "my-t12-bucket-depends-on"
#   #   lifecycle {
#   #     create_before_destroy = true
#   #   }
# #   depends_on = [
# #     aws_instance.my_server
# #   ]
# }

locals {
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
}

resource "aws_instance" "my_server" {
  count = 2
#   for_each = {
#     nano = "t2.nano"
#     micro = "t2.micro"
#     small = "t2.small"
#   }
  ami           = local.ami
#   instance_type = each.value
  instance_type = local.instance_type
#   depends_on = [
#     aws_s3_bucket.t_bucket
#   ]
#   tags = {
#     Name = "Server-${each.key} /n ${each.value}"
#   }
    tags = {
      Name = "Server-${local.instance_type}"
    }
}

output "public_ip" {
  value = values(aws_instance.my_server)[*].public_ip
}
