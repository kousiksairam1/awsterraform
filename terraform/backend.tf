terraform {
  backend "remote" {
    organization = "YOUR_ORG_NAME"

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
