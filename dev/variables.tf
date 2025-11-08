variable "aws_region" {
  description = "AWS region for IAM deployment"
  type        = string
}

variable "env" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "user_names" {
  description = "List of IAM user names to create"
  type        = list(string)
}

variable "tags" {
  description = "Tags for IAM users"
  type        = map(string)
}
