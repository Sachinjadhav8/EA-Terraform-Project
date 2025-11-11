variable "region" {}
variable "vpc_name" {
  description = "Name tag of the existing VPC"
}


variable "private_subnet_ids" { type = list(string) }

# Directory
variable "directory_dns_name" {
  description = "FQDN of the AWS Managed Microsoft AD domain"
  type        = string
}

variable "directory_admin_password" { sensitive = true }



# FSx
variable "fsx_security_group_id" {}
variable "fsx_size" {}
variable "fsx_throughput" {}


/*
# DataSync Agent
variable "agent_name" {}
variable "activation_key" {}

# SMB Source
variable "smb_server" {}
variable "smb_subdir" {}
variable "smb_user" {}
variable "smb_password" { sensitive = true }

# FSx Destination
variable "fsx_location_sg_arn" {}
variable "fsx_subdir" {}
variable "fsx_user" {}
variable "fsx_password" { sensitive = true }
variable "fsx_domain" {}

# Task
variable "task_name" {}
variable "run_now" { default = true }

*/