resource "aws_datasync_task" "this" {
  name                     = var.task_name
  source_location_arn      = var.source_location_arn
  destination_location_arn = var.destination_location_arn

  options {
    verify_mode = "POINT_IN_TIME_CONSISTENT"
  }
}

resource "aws_datasync_task_execution" "run" {
  count    = var.run_now ? 1 : 0
  task_arn = aws_datasync_task.this.arn
}
