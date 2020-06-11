################ Non Mfa Login #################################
resource "aws_cloudwatch_log_metric_filter" "non_mfa_login" {
  name           = "non_mfa_login"
  pattern        = "{ $.eventName = ConsoleLogin && $.additionalEventData.MFAUsed = No }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "nonmfalogin"
    namespace = "non_mfa_login"
    value     = "1"
  }
}


################ Un-Encrypted_Volume #################################

resource "aws_cloudwatch_log_metric_filter" "unencryped_volume" {
  name           = "unencryped_volume"
  pattern        = "{ ($.eventName = CreateVolume && $.responseElements.encrypted IS FALSE) }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "unencrypedvolume"
    namespace = "unencryped_volume"
    value     = "1"
  }
}


################ ElasticIp Creation #################################

resource "aws_cloudwatch_log_metric_filter" "elastic_ip" {
  name           = "elastic_ip"
  pattern        = "{ $.eventName = AssociateAddress || $.eventName = AllocateAddress }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "elasticip"
    namespace = "elastic_ip"
    value     = "1"
  }
}

################ Public_Ec2_Instances #################################

resource "aws_cloudwatch_log_metric_filter" "public_instances" {
  name           = "public_instances"
  pattern        = "{ $.eventName = RunInstances }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "publicinstances"
    namespace = "public_instances"
    value     = "1"
  }
}


################ Unecrypted_Bucket ####################################

resource "aws_cloudwatch_log_metric_filter" "unecrypted_buckets" {
  name           = "unecrypted_buckets"
  pattern        = "{ $.eventName = CreateBucket }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "unecryptedbuckets"
    namespace = "unecrypted_buckets"
    value     = "1"
  }
}

################ Security Group Activity ####################################

resource "aws_cloudwatch_log_metric_filter" "securitygroup_activity" {
  name           = "securitygroup_activity"
  pattern        = "{ $.eventName = AuthorizeSecurityGroupIngress || $.eventName = RevokeSecurityGroupIngress }"
  log_group_name = "${var.loggroupname}"

  metric_transformation {
    name      = "securitygroupactivity"
    namespace = "securitygroup_activity"
    value     = "1"
  }
}
