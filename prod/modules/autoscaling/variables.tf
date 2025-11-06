variable "vpc_name" {}
variable "environment" {}
variable "tier" {}
variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "security_group_id" {}
variable "target_group_arn" {}
variable "is_public" {
  description = "If true, use public subnets, else private subnets"
  type        = bool
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "min_size" { default = 1 }
variable "max_size" { default = 4 }
variable "desired_capacity" { default = 2 }
