####################################################
###Non Mfa Login Alarm #############################
####################################################

resource "aws_cloudwatch_metric_alarm" "non_mfa_alarm" {
  alarm_name          = "NO_MFA"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.nonmfa_metric_name}"
  namespace           = "${var.nonmfa_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for Non Mfa Login"
  alarm_actions       = ["${var.sns_topic}"]
}

######################################################
####### Unencrypted Volume Alarm #####################
######################################################

resource "aws_cloudwatch_metric_alarm" "unencryped_volume_alarm" {
  alarm_name          = "UN_ENCRYPTED_VOLUME"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.unencryptedvolume_metric_name}"
  namespace           = "${var.unencryptedvolume_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for UnEncrypted Volume Creation"
  alarm_actions       = ["${var.sns_topic}"]
}

######################################################
########## ElasticIp Creation Alarm ##################
######################################################

resource "aws_cloudwatch_metric_alarm" "elasticip_alarm" {
  alarm_name          = "ELASTIC_IP"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.elasticip_metric_name}"
  namespace           = "${var.elasticip_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for elastic ip Creation"
  alarm_actions       = ["${var.sns_topic}"]
}

######################################################
########## Public Ec2 Instances Creation Alarm #######
######################################################

resource "aws_cloudwatch_metric_alarm" "public_ec2_alarm" {
  alarm_name          = "PUBLIC_EC2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.public_ec2_metric_name}"
  namespace           = "${var.public_ec2_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for public Ec2 Instances Creation"
  alarm_actions       = ["${var.sns_topic}"]
}


######################################################
########## UnEncrypted Bucket Creation Alarm #########
######################################################

resource "aws_cloudwatch_metric_alarm" "unencrypted_bucket_alarm" {
  alarm_name          = "UNENCRYPTED_BUCKET"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.unencrypted_bucket_metric_name}"
  namespace           = "${var.unencrypted_bucket_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for Unencrypted Bucket Creation"
  alarm_actions       = ["${var.sns_topic}"]
}

######################################################
########## Security Group Activity Alarm #############
######################################################

resource "aws_cloudwatch_metric_alarm" "securitygroup_activity_alarm" {
  alarm_name          = "SECURITYGROUP_ACTIVITY"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${var.securitygroup_activity_metric_name}"
  namespace           = "${var.securitygroup_activity_metric_namespace}"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "Alarm for Security Group Activity"
  alarm_actions       = ["${var.sns_topic}"]
}
