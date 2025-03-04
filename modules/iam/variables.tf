variable "lambda_arn" {
  description = "Lambda function ARN for API Gateway permissions"
  type        = string
}

variable "apigateway_api_id" {
  description = "API Gateway ID"
  type        = string
}
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
