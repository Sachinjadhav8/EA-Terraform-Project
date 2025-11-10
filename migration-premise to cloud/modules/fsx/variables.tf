variable "subnet_ids"          { type = list(string) }
variable "preferred_subnet_id" { type = string }
variable "security_group_id"   { type = string }
variable "storage_capacity_gib"{ type = number }
variable "throughput_mbps"     { type = number }
variable "ad_id"               { type = string }
