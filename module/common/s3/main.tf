resource "aws_s3_bucket" "jenkins_artifacts_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "jenkins_artifacts_bucket_ownership_controls" {
  bucket = aws_s3_bucket.jenkins_artifacts_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "jenkins_artifacts_bucket_acl" {
  bucket = aws_s3_bucket.jenkins_artifacts_bucket.id
  acl    = var.acl
}

output "bucket_name" {
  value = aws_s3_bucket.jenkins_artifacts_bucket.id
}
