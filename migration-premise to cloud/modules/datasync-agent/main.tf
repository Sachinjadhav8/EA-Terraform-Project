resource "aws_datasync_agent" "this" {
  activation_key = var.activation_key
  name           = var.agent_name
}
