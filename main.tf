terraform {
  required_version = ">= 0.14.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.24.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
