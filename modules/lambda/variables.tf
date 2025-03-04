variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM Role ARN for Lambda"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for Lambda networking"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for Lambda function"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group for Lambda function"
  type        = string
}

variable "db_endpoint" {
  description = "RDS Endpoint for database connection"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "rds_vpc_endpoint" {
  description = "VPC Endpoint ID for RDS"
  type        = string
}
