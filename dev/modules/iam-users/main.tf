# =====================================
# Get account alias OR fallback to account ID
# =====================================

# Get AWS account ID (always available)
data "aws_caller_identity" "current" {}

# Try to read alias (some accounts don't have one)
# Adding depends_on ensures Terraform waits until users are created (avoiding empty result)
data "aws_iam_account_alias" "alias" {
  depends_on = [aws_iam_user.users]
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  alias      = try(data.aws_iam_account_alias.alias.account_alias, "")
  login_url  = local.alias != "" ?
    format("https://%s.signin.aws.amazon.com/console", local.alias) :
    format("https://%s.signin.aws.amazon.com/console", local.account_id)
}


resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.value
  path     = "/"
  tags     = merge(var.tags, { Environment = var.env })
}

# Generate random strong passwords
/*
resource "random_password" "initial_passwords" {
  for_each = aws_iam_user.users
  length   = 16
  special  = true
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}
*/
# Create AWS Console login profile (no password reset)
resource "aws_iam_user_login_profile" "login_profiles" {
  for_each                = aws_iam_user.users
  user                    = each.value.name
  password_reset_required = false
}

# Deny users the ability to change their password
resource "aws_iam_user_policy" "deny_password_change" {
  for_each = aws_iam_user.users
  name     = "DenyPasswordChange"
  user     = each.value.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Deny",
        Action = [
          "iam:ChangePassword",
          "iam:UpdateLoginProfile"
        ],
        Resource = "*"
      }
    ]
  })
}

# Write usernames and passwords to local file
resource "local_file" "iam_user_passwords" {
  filename = "${path.module}/iam_user_credentials_${var.env}.txt"

  content = join(
    "\n",
    concat(
      [
        "IAM User Credentials (${var.env} environment):",
        "-------------------------------------------------",
        "",
        format("Login URL: %s", local.login_url),
        ""
      ],
      [
        for username, lp in aws_iam_user_login_profile.login_profiles :
        format("Username: %s | Password: %s", username, lp.password)
      ]
    )
  )
}


