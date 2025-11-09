variable "group_names" {
  description = "List of IAM group names"
  type        = list(string)
}

variable "group_policies" {
  description = "Map of group name → list of AWS policy ARNs"
  type        = map(list(string))
}
