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

# Fetch VPC by Name
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Fetch Subnet by Name
data "aws_subnet" "selected_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

# Fetch Security Group by Name
data "aws_security_group" "selected_sg" {
  filter {
    name   = "tag:Name"
    values = [var.sg_name]
  }
  vpc_id = data.aws_vpc.selected.id
}


# S3 Bucket Module
module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

# EC2 Module (depends on S3)
module "ec2_instance" {
  source            = "./modules/ec2"
  subnet_id         = data.aws_subnet.selected_subnet.id
  security_group_id = data.aws_security_group.selected_sg.id
  bucket_arn        = module.s3_bucket.bucket_arn
  bucket_name       = module.s3_bucket.bucket_name

  depends_on = [module.s3_bucket]
}
