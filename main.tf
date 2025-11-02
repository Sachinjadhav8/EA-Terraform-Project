terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "jadhavsachinn01-org"  # your Terraform Cloud org name

    workspaces {
      name = "energyA"  # your workspace name
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "energya-terraform-demo-bucketxxx10"
  tags = {
    Name = "EnergyA Demo"
  }
}
