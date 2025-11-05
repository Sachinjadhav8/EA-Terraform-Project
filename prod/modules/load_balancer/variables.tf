variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "instance_ids" {
  type = list(string)
}

variable "is_public" {
  description = "If true, create internet-facing ALB. If false, create internal ALB."
  type        = bool
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "target_port" {
  type    = number
  default = 80
}

variable "health_check_path" {
  type    = string
  default = "/"
}
