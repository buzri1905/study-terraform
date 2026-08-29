output "bucket_name" {
  description = "Name of the bucket that was created."
  value       = aws_s3_bucket.hello.id
}

output "bucket_arn" {
  description = "ARN of the bucket, useful as input to IAM policies later."
  value       = aws_s3_bucket.hello.arn
}

output "object_url" {
  description = "s3:// URI of the object written into the bucket."
  value       = "s3://${aws_s3_bucket.hello.id}/${aws_s3_object.readme.key}"
}
