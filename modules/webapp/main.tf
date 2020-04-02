resource "aws_s3_bucket_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = var.bucket
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}
