output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}
