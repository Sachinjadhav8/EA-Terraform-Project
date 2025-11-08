output "iam_user_credentials" {
  description = "List of IAM users with passwords and console URL"
  value       = module.iam_users.user_credentials
  sensitive   = true
}

output "credentials_file" {
  description = "Path to generated IAM credentials file"
  value       = module.iam_users.credentials_file
  sensitive   = true
}
