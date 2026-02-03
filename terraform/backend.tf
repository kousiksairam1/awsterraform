terraform {
  backend "remote" {
    organization = "Demoterraform123"

    workspaces {
      name = "aws-eks-poc"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
