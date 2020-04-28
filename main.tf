variable "prod_region" {
  description = "This is where your EC2 instance will be deployed."
}

variable "dev_region" {
  description = "This is where your EC2 instance will be deployed."
}

variable "dev_prefix" {
  default = "dev"
}

variable "prod_prefix" {
  default = "prod"
}

provider "aws" {
  region = var.dev_region
  alias  = "dev"
}

resource "random_pet" "petname_dev" {
  length    = 3
  separator = "-"
}

resource "random_pet" "petname_prod" {
  length    = 3
  separator = "-"
}
resource "aws_s3_bucket" "dev" {
  provider = aws.dev
  bucket   = "${var.dev_prefix}-${random_pet.petname_dev.id}"
  acl      = "public-read"

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
                "arn:aws:s3:::${var.dev_prefix}-${random_pet.petname_dev.id}/*"
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

resource "aws_s3_bucket_object" "dev" {
  provider     = aws.dev
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.dev.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}

resource "aws_s3_bucket" "prod" {
  bucket = "${var.prod_prefix}-${random_pet.petname_prod.id}"
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
                "arn:aws:s3:::${var.prod_prefix}-${random_pet.petname_prod.id}/*"
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
