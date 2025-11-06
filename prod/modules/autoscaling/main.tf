# Launch Template
resource "aws_launch_template" "this" {
  name_prefix   = "${var.vpc_name}-${var.tier}-lt-"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    systemctl enable httpd
    systemctl start httpd
    echo "Healthy from ${var.tier} ASG instance" > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.vpc_name}-${var.tier}-ec2"
      Environment = var.environment
      Tier        = var.tier
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "this" {
  name                = "${var.vpc_name}-${var.tier}-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.is_public ? var.public_subnets : var.private_subnets
  target_group_arns   = [var.target_group_arn]
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-${var.tier}-asg-ec2"
    propagate_at_launch = true
  }
}

# Auto Scaling Policy (Target Tracking)
resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "${var.vpc_name}-${var.tier}-cpu-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}
