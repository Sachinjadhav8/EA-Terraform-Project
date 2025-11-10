variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "directory_name" {}
variable "admin_password" { sensitive = true }
