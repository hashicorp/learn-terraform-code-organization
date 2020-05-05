
output "prod_website_endpoint" {
  value = "http://${aws_s3_bucket.prod.website_endpoint}/index.html"
}
