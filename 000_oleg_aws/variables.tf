variable "instance_type" {
  type    = string
  default = "t2.micro"
}

locals {
  project_name = "terraform-test"
  owner        = "Oleg"
  env_name     = "dev"
}
