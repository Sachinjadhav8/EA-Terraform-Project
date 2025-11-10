resource "aws_directory_service_directory" "this" {
  name     = var.directory_name
  password = var.admin_password
  type     = "MicrosoftAD"
  edition  = "Standard"

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.private_subnet_ids
  }
}
