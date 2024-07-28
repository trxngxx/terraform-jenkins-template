resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = "private"
}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}
