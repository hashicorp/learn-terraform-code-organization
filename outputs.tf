# output "aws_dev_website_endpoint" {
#   value = "http://${aws_s3_bucket.dev.website_endpoint}/index.html"
# }

# output "aws_prod_website_endpoint" {
#   value = "http://${aws_s3_bucket.prod.website_endpoint}/index.html"
# }

output "bucket_name_dev" {
  value = aws_s3_bucket.dev.bucket
}

output "bucket_name_prd" {
  value = aws_s3_bucket.prod.bucket
}

output "localstack_dev_website_endpoint" {
  value = "http://localhost:4572/${aws_s3_bucket.dev.bucket}/index.html"
}

output "localstack_prod_website_endpoint" {
  value = "http://localhost:4572/${aws_s3_bucket.prod.bucket}/index.html"
}