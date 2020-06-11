output "cloudtrail_role_arn" {
  value = aws_iam_role.cloudtrail_role.arn
}

output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.cloudwatch_log_group.arn
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.cloudwatch_log_group.name
}
