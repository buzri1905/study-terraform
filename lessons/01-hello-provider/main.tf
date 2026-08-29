# The smallest useful loop: one provider, one resource, one output.
# Everything here is free to keep and free to destroy.

# S3 bucket names are globally unique. A random suffix keeps `apply` from
# colliding with someone else's bucket, and stays stable across applies
# because the random_id is itself tracked in state.
resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "hello" {
  bucket = "${var.project}-hello-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "hello" {
  bucket = aws_s3_bucket.hello.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Referencing another resource's attribute is what builds the dependency
# graph -- no explicit depends_on is needed here.
resource "aws_s3_object" "readme" {
  bucket       = aws_s3_bucket.hello.id
  key          = "hello.txt"
  content      = "Created by Terraform on ${timestamp()}\n"
  content_type = "text/plain"

  # timestamp() changes on every plan, which would leave this resource
  # perpetually dirty. Ignore it after the first write.
  lifecycle {
    ignore_changes = [content]
  }
}
