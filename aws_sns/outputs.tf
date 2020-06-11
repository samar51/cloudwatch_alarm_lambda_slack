output "aws_sns_arn" {
  value = aws_sns_topic.sns_lambda_alarm.arn
}
