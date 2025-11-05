# Generate a private key locally (inside Terraform run)
#resource "tls_private_key" "ec2_key" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

# Create a Key Pair in AWS using the public key
#resource "aws_key_pair" "ec2_keypair" {
#  key_name   = "energy-key"
#  public_key = tls_private_key.ec2_key.public_key_openssh
#}

# Save private key to file (⚠️ only works locally, not in Terraform Cloud)
#resource "local_file" "private_key" {
#  content  = tls_private_key.ec2_key.private_key_pem
#  filename = "${path.module}/energy-key.pem"
#}
