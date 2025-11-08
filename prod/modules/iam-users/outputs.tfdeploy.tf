output "user_names" {
  value = [for u in aws_iam_user.users : u.name]
}

output "credentials_file" {
  value     = local_file.iam_user_passwords.filename
  sensitive = true
}
