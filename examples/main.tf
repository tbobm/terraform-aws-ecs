module "ecs" {
  source = "../"

  container = {
    image = var.container.image
  }

  networking = {
    vpc_id     = var.vpc_id
    subnet_ids = data.aws_subnet_ids.this.ids
  }

  ecs_values = {
    ecs_task_arn = ""
  }

  addons = {
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
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  type        = string
  description = "The AWS Region used to configure the AWS provider."
}

variable "vpc_id" {
  type        = string
  description = "The AWS VPC ID in which the ECS tasks will run."
}

variable "container" {
  type        = map(string)
  description = "The ECS Task simplified configuration."
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}

output "this" {
  value       = module.ecs
  sensitive   = true
  description = "The ECS module outputs."
}

output "addons" {
  value = module.ecs.addons
}
