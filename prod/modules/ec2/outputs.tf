/*
output "instance_ids" {
  value = aws_instance.this[*].id
}

output "public_ips" {
  value = aws_instance.this[*].public_ip
}
*/

output "instance_name_ip_map" {
  description = "Mapping of EC2 instance names to their public/private IPs"
  value = [
    for instance in aws_instance.this :
    "${instance.tags["Name"]} → ${coalesce(instance.public_ip, instance.private_ip)}"
  ]
}

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.this[*].id
}
