output "login_url" {
  description = "AWS IAM login URL for this account"
  value       = local.login_url
}

output "credentials_file" {
  description = "Local file containing usernames, passwords, and login URL"
  value       = local_file.iam_user_passwords.filename
  sensitive   = true
}