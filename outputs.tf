output "bucket_name_dev" {
  value = aws_s3_bucket.dev.bucket
}

output "bucket_name_prd" {
  value = aws_s3_bucket.prod.bucket
}
