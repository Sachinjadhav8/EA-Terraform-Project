variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "directory_dns_name" {
  description = "FQDN of Directory (e.g. corp.example.com)"
  type        = string
}
variable "admin_password" { sensitive = true }
