terraform {
  required_version = "~> 1.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Option A: Terraform Cloud backend (uncomment and set values for your org/workspace)
  cloud {
    organization = "EA-ORG"   # <-- replace with your Terraform Cloud org name
    workspaces {
      name = "EA-Terraform-Project"  # <-- workspace name in Terraform Cloud
    }
  }
}