module "vpc" {
  source = "./modules/vpc"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  environment          = var.environment
}

/*
module "ec2" {
  source = "./modules/ec2"

  ami_id            = data.aws_ssm_parameter.amazon_linux.value
  instance_type     = var.instance_type
  subnet_ids        = module.vpc.public_subnets
  security_group_id = module.ec2_sg.security_group_id
  key_name          = var.key_name
  instance_count    = var.instance_count
  vpc_name         = var.vpc_name
  environment      = var.environment
}
*/

module "public_ec2" {
  source              = "./modules/ec2"
  instance_count      = 3
  subnet_ids          = module.vpc.public_subnets
  ami_id              = data.aws_ssm_parameter.amazon_linux.value
  instance_type       = var.instance_type
  key_name            = var.key_name
  security_group_id   = module.ec2_sg.security_group_id
  associate_public_ip = true
  vpc_name         = var.vpc_name
  environment      = var.environment
  tier                = "public"
}

module "private_ec2" {
  source              = "./modules/ec2"
  instance_count      = 2
  subnet_ids          = module.vpc.private_subnets
  ami_id              = data.aws_ssm_parameter.amazon_linux.value
  instance_type       = var.instance_type
  key_name            = var.key_name
  security_group_id   = module.ec2_sg.security_group_id
  associate_public_ip = false
  vpc_name         = var.vpc_name
  environment      = var.environment
  tier                = "private"
}


module "ec2_sg" {
  source      = "./modules/security_group"
  vpc_name        = var.vpc_name
  description = "Allow SSH and HTTP access"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment

  ingress_rules = [
    {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
