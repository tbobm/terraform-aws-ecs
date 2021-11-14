# Terraform ECS Module

[![terraform-aws-ecs](https://github.com/tbobm/terraform-aws-ecs/actions/workflows/terraform.yml/badge.svg)](https://github.com/tbobm/terraform-aws-ecs/actions/workflows/terraform.yml)

Simple Terraform module to deploy an ECS task using AWS Fargate including addons (Load Balancer, ECR, CI credentials)

## Example usage

### Bootstrapped setup

```hcl
module "ecr" {
  source  = "tbobm/ecs/aws"
  # version = "" use latest version

  container = {
    image = "particuleio/helloworld"
  }

  networking = {
    vpc_id = "vpc-xxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxx"]
  }
}
```

### Restricted setup

Simply setup an ECS Cluster and Service based on `container.image`.

```hcl
module "ecr" {
  source  = "tbobm/ecs/aws"
  # version = "" use latest version

  container = {
    image = "particuleio/helloworld"
  }

  networking = {
    vpc_id = "vpc-xxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxx"]
  }
  addons = {
    iam = {
      enable = false
    }
    ecr = {
      enable = false
    }
    loadbalancer = {
      enable = false
    }
  }
}
```

### Use an external ECS Task definition

```hcl
module "ecr" {
  source  = "tbobm/ecs/aws"
  # version = "" use latest version

  ecs_values = {
    ecs_task_arn = "arn:aws:ecs:<region>:<aws_account_id>:task-definition/<task_family>:1"
  }
  networking = {
    vpc_id = "vpc-xxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxx"]
  }
}
```

## Doc generation

Code formatting and documentation for variables and outputs is generated using
[pre-commit-terraform
hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses
[terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these
instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install)
to install pre-commit locally.

And install `terraform-docs` with `go get github.com/segmentio/terraform-docs`
or `brew install terraform-docs`.

## Contributing

Report issues/questions/feature requests on in the
[issues](https://github.com/particuleio/terraform-kubernetes-addons/issues/new)
section.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_access_key.publisher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_user.publisher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.publisher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | Configuration of each addon that can be toggles on and off | `any` | `{}` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"eu-west-3"` | no |
| <a name="input_container"></a> [container](#input\_container) | Container configuration to deploy | `any` | `{}` | no |
| <a name="input_ecr_values"></a> [ecr\_values](#input\_ecr\_values) | AWS ECR configuration | `any` | `{}` | no |
| <a name="input_ecs_values"></a> [ecs\_values](#input\_ecs\_values) | AWS ECS configuration | `any` | `{}` | no |
| <a name="input_lb_values"></a> [lb\_values](#input\_lb\_values) | AWS Load Balancer configuration | `any` | `{}` | no |
| <a name="input_networking"></a> [networking](#input\_networking) | AWS networking configuration (subnet\_ids, vpc\_id) | <pre>object({<br>    vpc_id     = string<br>    subnet_ids = list(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addons"></a> [addons](#output\_addons) | The Addons configuration |
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | The public ALB DNS |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | The AWS region used |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | Container name for the ECS task |
| <a name="output_ecr_repository_name"></a> [ecr\_repository\_name](#output\_ecr\_repository\_name) | The ECR repository name |
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | The ECR repository URL |
| <a name="output_ecs_cluster"></a> [ecs\_cluster](#output\_ecs\_cluster) | The ECS cluster name |
| <a name="output_ecs_service"></a> [ecs\_service](#output\_ecs\_service) | The ECS service name |
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | The AWS Load Balancer resources (`loadbalancer`, `target_group` and `lb_listener`) |
| <a name="output_publisher_access_key"></a> [publisher\_access\_key](#output\_publisher\_access\_key) | AWS\_ACCESS\_KEY to publish to ECR |
| <a name="output_publisher_secret_key"></a> [publisher\_secret\_key](#output\_publisher\_secret\_key) | AWS\_SECRET\_ACCESS\_KEY to upload to the ECR |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
