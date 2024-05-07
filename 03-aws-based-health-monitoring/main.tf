resource "aws_sns_topic" "health_check_notifications" {
  name = var.app_name
}


resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.health_check_notifications.arn
  protocol  = "email"
  endpoint  = var.email_id
}


resource "aws_cloudwatch_metric_alarm" "api_health_check_alarm" {
  alarm_name          = "Critical | ${var.app_name} Health check"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = 60
  statistic           = "Minimum"
  threshold           = 0
  alarm_description   = "This alarm is triggered when API health check fails."
  treat_missing_data  = "breaching"
  alarm_actions       = [aws_sns_topic.health_check_notifications.arn]
  tags                = var.tags
  dimensions = {
    HealthCheckId = aws_route53_health_check.api_health_check.id
  }
  depends_on = [aws_route53_health_check.api_health_check]
}

resource "aws_route53_health_check" "api_health_check" {
  fqdn                    = "record.${var.health_check_configuration.url}"
  port                    = var.health_check_configuration.port
  type                    = var.health_check_configuration.protocol
  resource_path           = var.health_check_configuration.path
  failure_threshold       = var.health_check_configuration.failure_threshold
  request_interval        = var.health_check_configuration.request_interval
  tags                    = var.tags
}
