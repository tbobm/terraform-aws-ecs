locals {
  region = var.aws_region
  ecr_defaults = {
    repository_name = "app-registry"
  }
  ecr = merge(local.ecr_defaults, var.ecr_values)

  ecs_defaults = {
    cluster_name = "ecs-cluster"
    service_name = "ecs-service"
    ecs_task_arn = null
  }
  ecs = merge(local.ecs_defaults, var.ecs_values)

  lb_defaults = {
    internal = false
    target_group = {
      name     = "tf-alb-tg"
      port     = 80
      protocol = "HTTP"
    }
  }
  lb = merge(local.lb_defaults, var.lb_values)

  container_defaults = {
    name  = "application"
    image = "particule/helloworld"
    ports = [80]
  }
  container = merge(local.container_defaults, var.container)

  addons_defaults = {
    loadbalancer = {
      enable = true
    }
    ecr = {
      enable = true
    }
    iam = {
      enable = true
    }
  }
  addons = {
    for key, defaults in local.addons_defaults :
    key => merge(defaults, lookup(var.addons, key, {}))
  }
}
