output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.react_cdn.domain_name}"
}
