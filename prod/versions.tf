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
      name = "EA-Terraform-Project-prod"  # <-- workspace name in Terraform Cloud
    }
  }

  # Option B: S3 backend (comment out cloud{} above if you use S3)
  # backend "s3" {
  #   bucket         = "mycompany-terraform-state"
  #   key            = "prod/vpc/terraform.tfstate"
  #   region         = "ap-southeast-2"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}
