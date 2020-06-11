data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudtrail_log_for_alert" {
  name                          = "cloudtrail_log_for_alert-v1"
  s3_bucket_name                = "${aws_s3_bucket.cloudtraillog-for-alert-bucket.id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  cloud_watch_logs_group_arn    = "${var.cloudwatch_log_group_arn}"
  cloud_watch_logs_role_arn     = "${var.cloudwatch_log_group_role_arn}"
  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }
  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }

}

resource "aws_s3_bucket" "cloudtraillog-for-alert-bucket" {
  bucket        = "${var.cloudwatch_s3_bucket}"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.cloudwatch_s3_bucket}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.cloudwatch_s3_bucket}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
lifecycle_rule {
    id      = "${var.cloudwatch_s3_bucket}"
    enabled = true
    prefix = "/"
    tags = {
      "rule"      = "${var.cloudwatch_s3_bucket}"
      "autoclean" = "true"
    }
    expiration {
      days = 30
    }
  }
}
