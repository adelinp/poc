output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_oai_iam_arn" {
  description = "Origin Access Identity's IAM ARN"
  value       = aws_cloudfront_origin_access_identity.oai.iam_arn
}
output "frontend_url" {
  description = "CloudFront distribution URL"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

