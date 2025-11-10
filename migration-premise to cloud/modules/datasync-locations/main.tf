resource "aws_datasync_location_smb" "source" {
  server_hostname = var.smb_server
  subdirectory    = var.smb_subdir
  user            = var.smb_user
  password        = var.smb_password
  agent_arns      = [var.agent_arn]
}

resource "aws_datasync_location_fsx_windows_file_system" "dest" {
  fsx_filesystem_arn = var.fsx_arn
  security_group_arns = [var.fsx_sg_arn]
  subdirectory       = var.fsx_subdir
  user               = var.fsx_user
  password           = var.fsx_password
  domain             = var.fsx_domain
}
