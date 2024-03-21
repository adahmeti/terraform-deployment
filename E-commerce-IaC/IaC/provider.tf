terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
  }
 backend "s3" {
    bucket = "ecommercetfstatefile"
    key    = "ecommerce/terraform.tfstate"
    region = "ca-central-1"
  }
}

