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
