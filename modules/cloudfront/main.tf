# Create a CloudFront Origin Access Identity (OAI) for secure S3 access
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Access Identity for S3"
}

# Create the CloudFront distribution
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"
    forwarded_values {  
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
