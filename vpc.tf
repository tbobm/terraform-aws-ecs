data "aws_vpc" "this" {
  id      = local.use_default_vpc ? null : local.vpc["id"]
  default = local.use_default_vpc
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnet" "this" {
  for_each = data.aws_subnet_ids.this.ids
  vpc_id   = data.aws_vpc.this.id
  id       = each.value
  # availability_zone = each.value
}
