resource "aws_lb" "alb" {
  count = local.addons.loadbalancer.enable == true ? 1 : 0

  name               = local.lb["name"]
  internal           = local.lb["internal"]
  load_balancer_type = "application"
  subnets            = data.aws_subnet.subnets.*.id
}

resource "aws_lb_target_group" "group" {
  count = local.addons.loadbalancer.enable ? 1 : 0

  name        = local.lb.target_group["name"]
  port        = local.lb.target_group["port"]
  protocol    = local.lb.target_group["protocol"]
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"

  depends_on = [aws_lb.alb.0]
}

resource "aws_lb_listener" "front_end" {
  count = local.addons.loadbalancer.enable ? 1 : 0

  load_balancer_arn = aws_lb.alb.0.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.group.0.arn
  }
}
