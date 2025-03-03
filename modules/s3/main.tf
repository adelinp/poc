# Create an S3 bucket for the website
resource "aws_s3_bucket" "website" {
  bucket_prefix = var.bucket_prefix
}

# Configure the bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

# Restrict access so only CloudFront (via OAI) can read objects
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        AWS = var.cloudfront_oai_iam_arn
      },
      Action    = "s3:GetObject",
      Resource  = "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
    }]
  })
}
