variable "aws_region" {
  type        = string
  default     = "eu-west-3"
  description = "AWS region"
}

variable "ecr_values" {
  type        = any
  default     = {}
  description = "AWS ECR configuration"
}

variable "ecs_values" {
  type        = any
  default     = {}
  description = "AWS ECS configuration"
}

variable "lb_values" {
  type        = any
  default     = {}
  description = "AWS Load Balancer configuration"
}

variable "networking" {
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
  })
  description = "AWS networking configuration (subnet_ids, vpc_id)"
}

variable "container" {
  type        = any
  default     = {}
  description = "Container configuration to deploy"
}

variable "addons" {
  type        = any
  default     = {}
  description = "Configuration of each addon that can be toggles on and off"
}
