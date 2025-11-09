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

/*
variable "credentials_bucket" {
  description = "S3 bucket where the IAM credentials file will be uploaded"
  type        = string
}
*/



