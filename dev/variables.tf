variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "user_names" {
  description = "List of IAM users to create"
  type        = list(string)
  default     = ["Ram", "Sham", "Avi", "Geeta", "Mohan", "Ashavini"]
}

variable "tags" {
  description = "Tags to apply to IAM users"
  type        = map(string)
  default = {
    ManagedBy  = "Terraform"
    Department = "CloudOps"
  }
}

/*
variable "credentials_bucket" {
  description = "S3 bucket to store IAM user credentials"
  type        = string
}
*/

variable "group_names" {
  type = list(string)
}

variable "group_policies" {
  type = map(list(string))
}

variable "vpc_name" {
  type        = string
  description = "Name of existing VPC"
}

variable "subnet_name" {
  type        = string
  description = "Name of existing subnet"
}

variable "sg_name" {
  type        = string
  description = "Name of existing security group"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}
