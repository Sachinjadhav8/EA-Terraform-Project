output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}

#output "private_key_pem" {
#  value     = tls_private_key.ec2_key.private_key_pem
#  sensitive = true
#}

#output "ami_id" {
#  value = data.aws_ssm_parameter.amazon_linux.value
#}

output "ec2_security_group_id" {
  description = "Security Group ID created by the ec2_sg module"
  value       = module.ec2_sg.security_group_id
}


/*
output "instance_ids" {
  value = module.ec2.instance_ids
}

output "public_ips" {
  value = module.ec2.public_ips
}
*/

output "private_ec2_name_ip_map" {
  description = "Private EC2 instance name → IP mapping"
  value       = module.private_ec2.instance_name_ip_map
}

output "public_ec2_name_ip_map" {
  description = "Public EC2 instance name → IP mapping"
  value       = module.public_ec2.instance_name_ip_map
}

