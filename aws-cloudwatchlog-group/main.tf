###########Cloudwatch log group######################
######for storing cloudtrail logs####################
#####################################################

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "cloudwatch_log_group_for_cloudtraillogs"
  retention_in_days = 30
  tags = {
    Environment = "Global"
    Application = "ALerting"
  }
}

data "aws_region" "region" {}

data "aws_caller_identity" "current" {}

locals {
  account_id = "${data.aws_caller_identity.current.account_id}"
  loggroupname = "${aws_cloudwatch_log_group.cloudwatch_log_group.name}"
  regionname = "${data.aws_region.region.name}"
}


resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "policy_to_access_logs"
  role = aws_iam_role.cloudtrail_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailCreateLogStream20141101",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
                "arn:aws:logs:${local.regionname}:${local.account_id}:log-group:${local.loggroupname}:log-stream:${local.account_id}_CloudTrail_${local.regionname}*"
            ]
        },
        {
            "Sid": "AWSCloudTrailPutLogEvents20141101",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${local.regionname}:${local.account_id}:log-group:${local.loggroupname}:log-stream:${local.account_id}_CloudTrail_${local.regionname}*"
            ]
        }
    ]
  }
  EOF
}


############################################################################
###cloudtrail role for putting cloudtrail logs to cloudwatchlog group######
############################################################################

resource "aws_iam_role" "cloudtrail_role" {
  name = "role_to_assume_cloudtrail"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
