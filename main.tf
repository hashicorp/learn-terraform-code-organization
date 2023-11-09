# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

resource "random_pet" "petname" {
  length    = 3
  separator = "-"
}

resource "aws_s3_bucket" "dev" {
  bucket = "${var.dev_prefix}-${random_pet.petname.id}"

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "dev" {
  bucket = aws_s3_bucket.dev.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "dev" {
  bucket = aws_s3_bucket.dev.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "dev" {
  bucket = aws_s3_bucket.dev.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "dev" {
  depends_on = [
    aws_s3_bucket_ownership_controls.dev,
    aws_s3_bucket_public_access_block.dev,
  ]

  bucket = aws_s3_bucket.dev.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "dev" {
  depends_on = [
    aws_s3_bucket_acl.dev
  ]

  bucket = aws_s3_bucket.dev.id
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
                "arn:aws:s3:::${aws_s3_bucket.dev.id}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_object" "dev" {
  key          = "index.html"
  bucket       = aws_s3_bucket.dev.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}

resource "aws_s3_bucket" "prod" {
  bucket = "${var.prod_prefix}-${random_pet.petname.id}"

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "prod" {
  bucket = aws_s3_bucket.prod.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "prod" {
  bucket = aws_s3_bucket.prod.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "prod" {
  bucket = aws_s3_bucket.prod.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "prod" {
  depends_on = [
    aws_s3_bucket_ownership_controls.prod,
    aws_s3_bucket_public_access_block.prod,
  ]

  bucket = aws_s3_bucket.prod.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "prod" {
  depends_on = [
    aws_s3_bucket_acl.prod
  ]

  bucket = aws_s3_bucket.prod.id
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
                "arn:aws:s3:::${aws_s3_bucket.prod.id}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_object" "prod" {
  key          = "index.html"
  bucket       = aws_s3_bucket.prod.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
