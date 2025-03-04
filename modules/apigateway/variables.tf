variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function"
  type        = string
}
variable "aws_region" {
  description = "AWS region to use in API Gateway integration URIs"
  type        = string
}
