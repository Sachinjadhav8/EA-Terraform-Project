variable "user_names" {
  description = "List of IAM users to create"
  type        = list(string)
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Tags for IAM users"
  type        = map(string)
  default     = {}
}
