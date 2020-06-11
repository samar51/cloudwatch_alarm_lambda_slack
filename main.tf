module "cloudwatch_log_group"{
  source = "./aws-cloudwatchlog-group"
}

module "lambda_function" {
 source = "./aws_lambda"
}

module "sns_topic" {
  source = "./aws_sns"
  lambda_endpoint ="${module.lambda_function.aws_lambda_arn}"
  lambda_function_name = "${module.lambda_function.aws_lambda_function_name}"
}

module "cloud_metric_filter" {
  source = "./aws_cloudwatch_metricfilter"
  loggroupname = "${module.cloudwatch_log_group.cloudwatch_log_group_name}"
}

module "cloudwatch_alarm" {
  source = "./aws_alarm"
  nonmfa_metric_name = "${module.cloud_metric_filter.cloudwatchlog_non_mfa_metric_name}"
  nonmfa_metric_namespace   = "${module.cloud_metric_filter.cloudwatchlog_non_mfa_metric_namespace}"
  unencryptedvolume_metric_name = "${module.cloud_metric_filter.cloudwatchlog_unecryptedv_metric_name}"
  unencryptedvolume_metric_namespace  = "${module.cloud_metric_filter.cloudwatchlog_unecryptedv_metric_namespace}"
  elasticip_metric_name = "${module.cloud_metric_filter.cloudwatchlog_elasticip_metric_name}"
  elasticip_metric_namespace  = "${module.cloud_metric_filter.cloudwatchlog_elasticip_metric_namespace}"
  public_ec2_metric_name  = "${module.cloud_metric_filter.cloudwatchlog_public_ec2_metric_name}"
  public_ec2_metric_namespace = "${module.cloud_metric_filter.cloudwatchlog_public_ec2_metric_namespace}"
  unencrypted_bucket_metric_name  = "${module.cloud_metric_filter.cloudwatchlog_unecryptedbucket_metric_name}"
  unencrypted_bucket_metric_namespace = "${module.cloud_metric_filter.cloudwatchlog_unecryptedbucket_metric_namespace}"
  securitygroup_activity_metric_name  = "${module.cloud_metric_filter.cloudwatchlog_securitygroupactivity_metric_name}"
  securitygroup_activity_metric_namespace = "${module.cloud_metric_filter.cloudwatchlog_securitygroupactivity_metric_namespace}"
  sns_topic          = "${module.sns_topic.aws_sns_arn}"
}

module "cloudtrail" {
  source = "./aws_cloudtrail"
  cloudwatch_log_group_arn = "${module.cloudwatch_log_group.cloudwatch_log_group_arn}"
  cloudwatch_log_group_role_arn = "${module.cloudwatch_log_group.cloudtrail_role_arn}"

}
