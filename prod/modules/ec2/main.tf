resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  key_name      = var.key_name
  associate_public_ip_address = var.associate_public_ip
#  key_name          = aws_key_pair.ec2_keypair.key_name  # 👈 Comes from root

  vpc_security_group_ids = [var.security_group_id]

  # ✅ Run Apache install script only for PUBLIC instances
  user_data = var.tier == "public" ? <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Healthy" > /var/www/html/index.html
              chown apache:apache /var/www/html/index.html
              chmod 644 /var/www/html/index.html
              systemctl restart httpd 
              EOF 
              : null

  tags = {
    Name        = "${var.vpc_name}-${var.tier}-ec2-${count.index + 1}"
    Environment = var.environment
    Tier        = var.tier
  }
}