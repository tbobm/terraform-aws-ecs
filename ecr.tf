resource "aws_ecr_repository" "this" {
  count = local.addons.ecr.enable ? 1 : 0

  name                 = local.ecr["repository_name"]
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository_policy" "this" {
  count = local.addons.ecr.enable ? 1 : 0

  repository = aws_ecr_repository.this.0.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the ${local.ecr["repository_name"]} repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}
