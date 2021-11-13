module "ecs" {
  source = "../"

  container = {
    image = var.container.image
  }

  vpc = {
    id = var.vpc.id
  }

  addons = {
    loadbalancer = {
      enable = false
    }
    ecr = {
      enable = false
    }
    iam = {
      enable = false
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

variable "vpc" {
  type        = map(string)
  description = "The AWS VPC configuration in which the ECS tasks will run."
}

variable "container" {
  type        = map(string)
  description = "The ECS Task simplified configuration."
}

output "this" {
  value       = module.ecs
  sensitive   = true
  description = "The ECS module outputs."
}

output "addons" {
  value = module.ecs.addons
}
