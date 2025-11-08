output "iam_users" {
  description = "List of IAM users created"
  value       = module.iam_users.login_url
}

output "iam_user_passwords_file" {
  description = "Path to the local credentials file"
  value       = module.iam_users.credentials_file
}
