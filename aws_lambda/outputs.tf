output "aws_lambda_arn" {
  value = aws_lambda_function.lambda_alert.arn
}

output "aws_lambda_function_name" {
  value = aws_lambda_function.lambda_alert.function_name
}
