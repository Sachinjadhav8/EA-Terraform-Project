# ===============================
# Outputs
# ===============================
output "user_credentials" {
  description = "List of users with username, password, and login URL"
  value       = local.credentials
  sensitive   = true
}

output "credentials_file" {
  description = "Local credentials file path"
  value       = local_file.iam_user_credentials.filename
  sensitive   = true
}