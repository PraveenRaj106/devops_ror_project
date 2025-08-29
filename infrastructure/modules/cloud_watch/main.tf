resource "aws_cloudwatch_log_group" "ecs_app_logs" {
  name              = "/ecs/app"
  retention_in_days = 7
}