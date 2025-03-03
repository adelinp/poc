variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project"
  default     = "3tier-POC"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
