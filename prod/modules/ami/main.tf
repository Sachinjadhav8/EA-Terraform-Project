resource "aws_ami_from_instance" "this" {
  name               = "${var.vpc_name}-${var.ami_name_suffix}"
  source_instance_id = var.source_instance_id
  description        = "Golden AMI created from ${var.source_instance_id}"

  tags = {
    Name        = "${var.vpc_name}-${var.ami_name_suffix}"
    Environment = var.environment
  }
}
