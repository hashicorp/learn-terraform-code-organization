output "website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.bucket.website_endpoint}/index.html"
}
