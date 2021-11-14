resource "aws_ecs_cluster" "this" {
  name               = local.ecs["cluster_name"]
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = "100"
  }
}

resource "aws_ecs_task_definition" "this" {
  count = lookup(local.ecs, "ecs_task_arn", "") != "" ? 0 : 1

  family = "service"
  requires_compatibilities = [
    "FARGATE",
  ]
  execution_role_arn = aws_iam_role.this.arn
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 512
  container_definitions = jsonencode([
    {
      name      = local.container.name
      image     = local.container.image
      essential = true
      portMappings = [
        for port in local.container.ports :
        {
          containerPort = port
          hostPort      = port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = local.ecs.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = lookup(local.ecs, "ecs_task_arn", "") != "" ? local.ecs.ecs_task_arn : aws_ecs_task_definition.this.0.arn
  desired_count   = 1

  network_configuration {
    subnets          = var.networking["subnet_ids"]
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = local.addons.loadbalancer.enable ? [1] : []

    content {
      target_group_arn = aws_lb_target_group.this.0.arn
      container_name   = local.container.name
      container_port   = 80
    }
  }
  deployment_controller {
    type = "ECS"
  }
  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 100
  }
}
