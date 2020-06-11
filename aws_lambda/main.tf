resource "aws_iam_role" "role_for_ec2_s3_logs" {
  name = "role_for_ec2_s3_logs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_dir    = "./python_lambda_function"
    output_path   = "lambda_function.zip"
}


resource "aws_lambda_function" "lambda_alert" {
  timeout       = 300
  filename      = "lambda_function.zip"
  function_name = "lambda_function_alert"
  role          = "${aws_iam_role.role_for_ec2_s3_logs.arn}"
  handler       = "alerts.lambda_handler"
  depends_on = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.lambda_logs_group","data.archive_file.lambda_zip"]

  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"

  runtime = "python3.7"

}

resource "aws_lambda_function_event_invoke_config" "lambda_event_config" {
  function_name                = "${aws_lambda_function.lambda_alert.function_name}"
  maximum_event_age_in_seconds = 300
  maximum_retry_attempts       = 1
}

resource "aws_cloudwatch_log_group" "lambda_logs_group" {
  name              = "/aws/lambda/lambda_function_alert"
  retention_in_days = 30
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:Describe*",
        "logs:Get*",
        "logs:List*",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:TestMetricFilter",
        "logs:FilterLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances"
      ],
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
        "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.role_for_ec2_s3_logs.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}
