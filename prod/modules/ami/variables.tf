variable "vpc_name" {
  description = "Name of the VPC or project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, preprod, prod)"
  type        = string
}

variable "source_instance_id" {
  description = "The ID of the EC2 instance to create an AMI from"
  type        = string
}

variable "ami_name_suffix" {
  description = "Suffix name for AMI (e.g., golden-ami or app-v1)"
  type        = string
  default     = "golden-ami"
}
