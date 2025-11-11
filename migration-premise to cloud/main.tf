data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${var.public_subnet_name_filter}*"]   # wildcard match
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}


# 1. Directory Service
module "directory" {
  source             = "./modules/directory"
  vpc_id             = data.aws_vpc.selected.id
  private_subnet_ids = data.aws_subnets.public.ids
  directory_dns_name     = var.directory_dns_name
  admin_password     = var.directory_admin_password
}


/*

# 2. FSx Windows
module "fsx" {
  source              = "./modules/fsx"
  subnet_ids          = var.private_subnet_ids
  preferred_subnet_id = var.private_subnet_ids[0]
  security_group_id   = var.fsx_security_group_id
  storage_capacity_gib= var.fsx_size
  throughput_mbps     = var.fsx_throughput
  ad_id               = module.directory.directory_id
}

# 3. DataSync Agent
module "datasync_agent" {
  source         = "./modules/datasync-agent"
  agent_name     = var.agent_name
  activation_key = var.activation_key
}

# 4. DataSync Locations
module "datasync_locations" {
  source = "./modules/datasync-locations"

  agent_arn     = module.datasync_agent.agent_arn

  # SMB source
  smb_server    = var.smb_server
  smb_subdir    = var.smb_subdir
  smb_user      = var.smb_user
  smb_password  = var.smb_password

  # FSx destination
  fsx_arn       = module.fsx.fsx_arn
  fsx_sg_arn    = var.fsx_location_sg_arn
  fsx_subdir    = var.fsx_subdir
  fsx_user      = var.fsx_user
  fsx_password  = var.fsx_password
  fsx_domain    = var.fsx_domain
}

# 5. DataSync Task
module "datasync_task" {
  source                   = "./modules/datasync-task"
  task_name                = var.task_name
  source_location_arn      = module.datasync_locations.source_loc_arn
  destination_location_arn = module.datasync_locations.dest_loc_arn
  run_now                  = var.run_now
}


*/
