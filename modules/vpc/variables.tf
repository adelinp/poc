variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
