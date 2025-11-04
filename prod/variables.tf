variable "region" {
  type        = string
  description = "AWS region to deploy resources in"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "List of Availability Zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create NAT Gateways"
  default     = false
}

variable "single_nat_gateway" {
  type        = bool
  description = "If true create a single NAT Gateway; if false create one NAT per AZ"
  default     = true
}
