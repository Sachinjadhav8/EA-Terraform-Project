variable "agent_arn" {}

variable "smb_server" {}
variable "smb_subdir" {}
variable "smb_user" {}
variable "smb_password" { sensitive = true }

variable "fsx_arn" {}
variable "fsx_sg_arn" {}
variable "fsx_subdir" {}
variable "fsx_user" {}
variable "fsx_password" { sensitive = true }
variable "fsx_domain" {}
