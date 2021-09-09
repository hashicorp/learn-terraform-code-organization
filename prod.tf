/*
provider "aws" {
 region = var.region
}


locals {
  bucket_name = "bucket"
}
*/


resource "aws_s3_bucket" "prod" {
  bucket = "${var.prod_prefix}-${local.bucket_name}"
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.prod_prefix}-${local.bucket_name}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "prod" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.prod.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}
