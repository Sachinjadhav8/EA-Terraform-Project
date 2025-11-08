module "iam_users" {
  source      = "./modules/iam-users"
  env         = var.env
  user_names  = var.user_names
  tags        = var.tags
}