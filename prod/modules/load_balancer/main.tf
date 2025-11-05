resource "aws_lb" "this" {
  name               = "energyA-${var.is_public ? "public" : "internal"}"
  load_balancer_type = "application"

  # Dynamically set internal/external based on is_public variable
  internal = var.is_public ? false : true

  security_groups = [var.security_group_id]
  subnets         = var.is_public ? var.public_subnets : var.private_subnets
}

# Target Group
resource "aws_lb_target_group" "this" {
  name     = "energyA-${var.is_public ? "public" : "internal"}-tg"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

# Attach EC2 instances
resource "aws_lb_target_group_attachment" "attachments" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = element(var.instance_ids, count.index)
  port             = var.target_port
}

# Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
