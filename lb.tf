resource "aws_lb" "this" {
  count = local.addons.loadbalancer.enable ? 1 : 0

  name        = lookup(local.lb, "name", null)
  name_prefix = lookup(local.lb, "name_prefix", null)

  internal           = local.lb["internal"]
  load_balancer_type = "application"

  subnets         = var.networking["subnet_ids"]
  security_groups = lookup(local.lb, "security_groups", [])

  enable_deletion_protection = lookup(local.lb, "enable_deletion_protection", false)

  tags = lookup(local.lb, "tags", {})
}

resource "aws_lb_target_group" "this" {
  count = local.addons.loadbalancer.enable ? 1 : 0

  name        = local.lb.target_group["name"]
  port        = local.lb.target_group["port"]
  protocol    = local.lb.target_group["protocol"]
  vpc_id      = var.networking["vpc_id"]
  target_type = "ip"

  depends_on = [aws_lb.this.0]
}

resource "aws_lb_listener" "this" {
  count = local.addons.loadbalancer.enable ? 1 : 0

  load_balancer_arn = aws_lb.this.0.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.0.arn
  }
}
