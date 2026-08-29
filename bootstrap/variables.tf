variable "region" {
  description = "AWS region that hosts the shared Terraform state bucket."
  type        = string
  default     = "ap-northeast-2"
}

variable "project" {
  description = "Prefix applied to every resource name in this repository."
  type        = string
  default     = "study-tf"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project))
    error_message = "project must be 3-20 chars of lowercase letters, digits, or hyphens."
  }
}
