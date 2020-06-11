output "cloudwatchlog_non_mfa_metric_name" {
  value = aws_cloudwatch_log_metric_filter.non_mfa_login.metric_transformation[0].name
}

output "cloudwatchlog_non_mfa_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.non_mfa_login.metric_transformation[0].namespace
}

output "cloudwatchlog_unecryptedv_metric_name" {
  value = aws_cloudwatch_log_metric_filter.unencryped_volume.metric_transformation[0].name
}

output "cloudwatchlog_unecryptedv_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.unencryped_volume.metric_transformation[0].namespace
}

output "cloudwatchlog_elasticip_metric_name" {
  value = aws_cloudwatch_log_metric_filter.elastic_ip.metric_transformation[0].name
}

output "cloudwatchlog_elasticip_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.elastic_ip.metric_transformation[0].namespace
}

output "cloudwatchlog_public_ec2_metric_name" {
  value = aws_cloudwatch_log_metric_filter.public_instances.metric_transformation[0].name
}

output "cloudwatchlog_public_ec2_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.public_instances.metric_transformation[0].namespace
}


output "cloudwatchlog_unecryptedbucket_metric_name" {
  value = aws_cloudwatch_log_metric_filter.unecrypted_buckets.metric_transformation[0].name
}

output "cloudwatchlog_unecryptedbucket_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.unecrypted_buckets.metric_transformation[0].namespace
}


output "cloudwatchlog_securitygroupactivity_metric_name" {
  value = aws_cloudwatch_log_metric_filter.securitygroup_activity.metric_transformation[0].name
}

output "cloudwatchlog_securitygroupactivity_metric_namespace" {
  value = aws_cloudwatch_log_metric_filter.securitygroup_activity.metric_transformation[0].namespace
}
