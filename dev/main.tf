
module "iam_users" {
  source      = "./modules/iam-users"
  user_names  = var.user_names
  env         = var.env
  tags        = var.tags
}
