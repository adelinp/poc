variable "project_name" {
  description = "Project"
  default     = "3tier-POC"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID for permissions"
  type        = string
}
