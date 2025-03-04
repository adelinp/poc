output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "lambda_sg_id" {
  description = "Security Group ID for Lambda"
  value       = aws_security_group.lambda_sg.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}
output "rds_vpc_endpoint_id" {
  description = "The ID of the RDS VPC endpoint"
  value       = aws_vpc_endpoint.rds.id
}
