provider "aws" {
  profile = "terraform"
  region  = "us-east-2"
}

resource "aws_iam_user" "user" {
  name = var.username
  tags = {
    ENV = format("%s-%s", var.tag_name, var.environment)
  }
}

resource "aws_iam_user_login_profile" "aicycle_demo_login_profile" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy_attachment" "user_ec2_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_policy" "tag_based_policy" {
  name        = "aicyle_iam_base_policy"
  description = "Policy to allow access only to resources tagged with ENV=${var.tag_name}-${var.environment}"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:startInstances",
          "ec2:stopInstances"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/ENV" : "${var.tag_name}-${var.environment}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.tag_based_policy.arn
}

output "user_password" {
  value = aws_iam_user_login_profile.aicycle_demo_login_profile.password
}
