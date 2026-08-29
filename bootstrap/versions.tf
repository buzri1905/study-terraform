terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Bootstrap intentionally uses local state: it creates the very bucket that
# every other configuration will use as its backend. Its terraform.tfstate is
# gitignored. Losing it is recoverable via `terraform import`.
provider "aws" {
  region = var.region

  default_tags {
    tags = local.common_tags
  }
}
