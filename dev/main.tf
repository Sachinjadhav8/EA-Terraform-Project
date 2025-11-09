module "iam_users" {
  source      = "./modules/iam-users"
  user_names  = var.user_names
  env         = var.env
  tags        = var.tags
}

module "iam_groups" {
  source         = "./modules/iam-groups"
  group_names    = var.group_names
  group_policies = var.group_policies
}
