output "bucket_id" {
  value = aws_s3_bucket.jenkins_artifacts_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.jenkins_artifacts_bucket.arn
}
