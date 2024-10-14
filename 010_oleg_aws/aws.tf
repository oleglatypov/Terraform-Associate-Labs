resource "aws_instance" "my_server" {
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = var.instance_type
  tags = {
    Name    = "terraform-test-server-${local.owner}"
    Project = local.project_name
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#
#   name = "my-vpc"
#   cidr = "10.0.0.0/16"
#
#   azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#
#   enable_nat_gateway = true
#   enable_vpn_gateway = true
#
#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }
