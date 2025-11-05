variable "vpc_name" { type = string }
variable "description" {
  type        = string
  default     = "Managed by Terraform"
}
variable "vpc_id" { type = string }

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "environment" { type = string }