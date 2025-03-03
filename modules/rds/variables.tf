variable "db_name" {
  description = "Database name"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+$", var.db_name))
    error_message = "DB identifier must start with a letter."
  }
}

variable "db_username" {
  description = "master username for RDS instance"
  type        = string
}

variable "db_password" {
  description = "master password for RDS instance"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "security group ID for RDS"
  type        = string
}
