resource "aws_cloudfront_origin_access_control" "cloud_origin_access_control" {
  name                              = "${aws_s3_bucket.s3.bucket_domain_name}_origin_access_control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "no-override"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name              = "${aws_s3_bucket.s3.id}.s3.${var.aws.region}.amazonaws.com"
    origin_id                = "${aws_s3_bucket.s3.id}.s3.${var.aws.region}.amazonaws.com"
    origin_access_control_id = aws_cloudfront_origin_access_control.cloud_origin_access_control.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_s3_bucket.s3.id}.s3.${var.aws.region}.amazonaws.com"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    name = var.aws.author
  }

  comment = var.cloud_front.distribution_comment

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }
}
