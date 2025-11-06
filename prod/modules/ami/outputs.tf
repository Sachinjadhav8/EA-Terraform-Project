output "ami_id" {
  description = "ID of the created AMI"
  value       = aws_ami_from_instance.this.id
}

output "ami_name" {
  description = "Name of the created AMI"
  value       = aws_ami_from_instance.this.name
}
