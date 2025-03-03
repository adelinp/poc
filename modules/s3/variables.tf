variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "cloudfront_oai_iam_arn" {
  description = "Origin Access Identity IAM ARN used to restrict S3 bucket access"
  type        = string
}
