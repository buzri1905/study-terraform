terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.region

  # Applied to every taggable resource this provider creates, so individual
  # resources only declare what is specific to them.
  default_tags {
    tags = {
      Project   = "study-terraform"
      Lesson    = "01-hello-provider"
      ManagedBy = "terraform"
    }
  }
}
