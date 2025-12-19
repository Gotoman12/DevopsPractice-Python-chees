provider "aws" {
  region = "us-east-1"
}

# Read usernames from file
locals {
  users = toset(split("\n", trim(file("${path.module}/user.txt"))))
}

# Create IAM users
resource "aws_iam_user" "users" {
  for_each = local.users
  name     = each.value
}

# S3 Full Access Policy
resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccess-Custom"
  description = "Full access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}

# Attach policy to users
resource "aws_iam_user_policy_attachment" "attach_policy" {
  for_each   = aws_iam_user.users
  user       = each.value.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}
