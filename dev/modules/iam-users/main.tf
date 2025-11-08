# =====================================
# IAM Users with Auto-generated Passwords (non-resettable)
# =====================================

resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.value
  path     = "/"
  tags     = merge(var.tags, { Environment = var.env })
}

# Generate random strong passwords
resource "random_password" "initial_passwords" {
  for_each = aws_iam_user.users
  length   = 16
  special  = true
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}

# Create AWS Console login profile (no password reset)
resource "aws_iam_user_login_profile" "login_profiles" {
  for_each                = aws_iam_user.users
  user                    = each.value.name
  password                = random_password.initial_passwords[each.key].result
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
        ""
      ],
      [
        for username in var.user_names :
        format("Username: %s | Password: %s", username, random_password.initial_passwords[username].result)
      ]
    )
  )
}

