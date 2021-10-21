module "ecr" {
  source = "../"

  container = {
    image = var.container.image
  }

  vpc = {
    id = var.vpc.id
  }
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
  value       = module.ecr
  sensitive   = true
  description = "The ECR module outputs."
}
