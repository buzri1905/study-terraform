output "state_bucket" {
  description = "Name of the S3 bucket to put in every backend \"s3\" block."
  value       = aws_s3_bucket.state.id
}

output "region" {
  description = "Region the state bucket lives in."
  value       = var.region
}

output "backend_snippet" {
  description = "Copy-paste backend block for a lesson or environment directory."
  value       = <<-EOT
    terraform {
      backend "s3" {
        bucket       = "${aws_s3_bucket.state.id}"
        key          = "<lessons/03-state-remote-backend>/terraform.tfstate"
        region       = "${var.region}"
        encrypt      = true
        use_lockfile = true
      }
    }
  EOT
}
