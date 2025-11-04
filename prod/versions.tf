terraform {
  required_version = "~> 1.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "remote" {
    organization = "EA-ORG"   # Replace with your actual Terraform Cloud organization name

    workspaces {
      name = "EA-Terraform-Project"               # Replace with your Terraform Cloud workspace name
    }
  }
}
