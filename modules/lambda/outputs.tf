output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.backend.arn
}

output "lambda_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.backend.function_name
}
