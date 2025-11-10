resource "aws_fsx_windows_file_system" "this" {
  storage_capacity    = var.storage_capacity_gib
  subnet_ids          = var.subnet_ids
  preferred_subnet_id = var.preferred_subnet_id
  throughput_capacity = var.throughput_mbps
  security_group_ids  = [var.security_group_id]
  active_directory_id = var.ad_id
  deployment_type     = "MULTI_AZ_1"
}
