variable "env" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "user_names" {
  description = "List of IAM user names"
  type        = list(string)
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
