output "website_endpoint" {
  value = "http://${aws_s3_bucket.bucket.website_endpoint}/index.html"
}
