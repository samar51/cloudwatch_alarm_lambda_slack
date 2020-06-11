resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.sns_lambda_alarm.arn}"
}

resource "aws_sns_topic" "sns_lambda_alarm" {
  name = "sns_lambda_alarm"
  delivery_policy = <<EOF
        {
          "http": {
          "defaultHealthyRetryPolicy": {
                "minDelayTarget": 1,
                "maxDelayTarget": 60,
                "numRetries": 20,
                "numMaxDelayRetries": 3,
                "numNoDelayRetries": 2,
                "numMinDelayRetries": 10,
                "backoffFunction": "exponential"
            },
          "disableSubscriptionOverrides": false,
              "defaultThrottlePolicy": {
                "maxReceivesPerSecond": 10
                }
              }
          }
        EOF
    }
resource "aws_sns_topic_subscription" "sns_target_subscrption" {
  topic_arn = "${aws_sns_topic.sns_lambda_alarm.arn}"
  protocol  = "lambda"
  endpoint  = "${var.lambda_endpoint}"
}
