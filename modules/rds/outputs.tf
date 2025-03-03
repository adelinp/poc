output "db_endpoint" {
  description = "endpoint of the RDS instance"
  value       = aws_db_instance.db.endpoint
}

output "db_username" {
  description = "database username"
  value       = aws_db_instance.db.username
}

output "db_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.db.arn
}
output "db_password" {
  description = "database password"
  value       = var.db_password
  sensitive   = true
}
