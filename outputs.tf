output "dev_website_endpoint" {
  value = "http://${aws_s3_bucket.dev.website_endpoint}/index.html"
}

output "prod_website_endpoint" {
  value = "http://${aws_s3_bucket.prod.website_endpoint}/index.html"
}
