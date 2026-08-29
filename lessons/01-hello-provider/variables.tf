variable "region" {
  description = "AWS region to create the practice bucket in."
  type        = string
  default     = "ap-northeast-1"
}

variable "project" {
  description = "Name prefix for created resources."
  type        = string
  default     = "study-tf"
}
