output "endpoint" {
  value = "${aws_s3_bucket.bucket.website_endpoint}/index.html"
}


output "bucket" {
  value = aws_s3_bucket.bucket.id
}
