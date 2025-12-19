provider "aws" {
  region = "us-east-1"
}

locals {
  users = toset(
    split("\n", trimspace(file("${path.module}/user.txt")))
  )
}

resource "aws_iam_user" "users" {
  for_each = local.users
  name     = each.value
}

resource "aws_iam_policy" "s3_full_access" {
  name = "S3FullAccess-Custom"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  for_each   = aws_iam_user.users
  user       = each.value.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}
