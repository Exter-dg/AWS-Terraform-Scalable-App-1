# Terraform Block
terraform {
  # Mentions which providers to use.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # ~> means any minor version 4.16.x is fine
      version = "~> 5.99"
    }
  }

  # Terraform version to use
  required_version = ">= 1.12.0"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "us-east-1"

  default_tags {
    tags = {
      CreatedBy = "Terraform"
      Project   = "AWS-Terraform-Scalable-App-1"
    }
  }
}
