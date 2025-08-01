

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "react-site-oac"
  description                       = "OAC for React site"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "never"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "react_cdn" {
  origin {
    domain_name = aws_s3_bucket.react_site.bucket_regional_domain_name
    origin_id   = "s3-react-site"

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-react-site"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "ReactAppCDN"
  }
}

