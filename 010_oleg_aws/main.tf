terraform {
#   cloud {
#     organization = "Oleglatypov"
#     workspaces {
#       name = "getting-started"
#     }
#   }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

