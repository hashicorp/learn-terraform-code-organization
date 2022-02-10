output "dev_website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.dev.website_endpoint}/index.html"
}

output "prod_website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.prod.website_endpoint}/index.html"
}
