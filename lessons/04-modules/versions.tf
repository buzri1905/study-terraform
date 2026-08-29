terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "study-terraform"
      Lesson    = "04-modules"
      ManagedBy = "terraform"
    }
  }
}

variable "region" {
  description = "AWS region for this lesson."
  type        = string
  default     = "ap-northeast-1"
}
