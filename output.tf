output "aws_region" {
  value       = local.region
  description = "The AWS region used"
}

output "app_url" {
  value       = local.addons.loadbalancer.enable ? aws_lb.this.0.dns_name : ""
  description = "The public ALB DNS"
}

output "publisher_access_key" {
  value       = aws_iam_access_key.publisher.id
  description = "AWS_ACCESS_KEY to publish to ECR"
}

output "publisher_secret_key" {
  value       = aws_iam_access_key.publisher.secret
  description = "AWS_SECRET_ACCESS_KEY to upload to the ECR"
  sensitive   = true
}

output "ecr_url" {
  value       = local.addons.ecr.enable ? aws_ecr_repository.this.0.repository_url : ""
  description = "The ECR repository URL"
}

output "ecr_repository_name" {
  value       = local.addons.ecr.enable ? aws_ecr_repository.this.0.name : ""
  description = "The ECR repository name"
}

output "ecs_cluster" {
  value       = aws_ecs_cluster.this.name
  description = "The ECS cluster name"
}

output "ecs_service" {
  value       = aws_ecs_service.this.name
  description = "The ECS service name"
}

output "container_name" {
  value       = local.container.name
  description = "Container name for the ECS task"
}

output "addons" {
  value       = local.addons
  description = "The Addons configuration"
}
