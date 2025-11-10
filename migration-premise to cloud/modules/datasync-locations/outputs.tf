output "source_loc_arn" { value = aws_datasync_location_smb.source.arn }
output "dest_loc_arn"   { value = aws_datasync_location_fsx_windows_file_system.dest.arn }
