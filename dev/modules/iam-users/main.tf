############################################
# IAM Users Module
# Creates IAM users, generates passwords, 
# and writes login info to a local file
############################################

# =========================================================
# Fetch AWS Account ID (used to build console login URL)
# =========================================================
data "aws_caller_identity" "current" {}

# =========================================================
# Create IAM Users
# =========================================================
resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.value
  path     = "/"
  tags     = merge(var.tags, { Environment = var.env })
}

# =========================================================
# Generate Secure Random Passwords
# =========================================================
resource "random_password" "passwords" {
  for_each = aws_iam_user.users

  length              = 16
  special             = true
  min_upper           = 2
  min_lower           = 2
  min_numeric         = 2
  min_special         = 2
}

# =========================================================
# Create AWS Console Login Profiles (Compatible with AWS v6+)
# =========================================================
# The AWS provider (v6+) no longer allows explicitly setting the password.
# So we create users, then use AWS CLI or automation to set initial passwords.
# Here we use lifecycle.ignore_changes to prevent Terraform from reapplying.

resource "aws_iam_user_login_profile" "login_profiles" {
  for_each                = aws_iam_user.users
  user                    = each.value.name
  password_reset_required = false

  # This lifecycle rule allows Terraform to keep the resource stable even if password changes
  lifecycle {
    ignore_changes = [password]
  }
}

# =========================================================
# Deny Users from Changing Password
# =========================================================
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

# =========================================================
# Construct AWS Console Login URL and Credentials Map
# =========================================================
locals {
  account_id = data.aws_caller_identity.current.account_id
  login_url  = "https://${local.account_id}.signin.aws.amazon.com/console"

  # Credentials array containing username, password, and login URL
  credentials = [
    for username in sort(keys(aws_iam_user.users)) : {
      username  = username
      password  = random_password.passwords[username].result
      login_url = local.login_url
    }
  ]
}

# =========================================================
# Write All Credentials to Local File
# =========================================================
resource "local_file" "iam_user_credentials" {
  filename = "${path.module}/iam_user_credentials_${var.env}.txt"

  content = join(
    "\n",
    concat(
      [
        "IAM User Credentials (${var.env} environment)",
        "Generated on: ${timestamp()}",
        "-------------------------------------------------",
        ""
      ],
      [
        for user in local.credentials :
        format("Username: %s | Password: %s | URL: %s", user.username, user.password, user.login_url)
      ]
    )
  )

  file_permission = "0600"
}