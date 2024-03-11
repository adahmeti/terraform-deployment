terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40"
    }
  }

  backend "s3" {
    bucket = "ecommerceadenis"
    key    = "tfstate/terraform.tfstate"
    region = "ca-central-1"
  }
}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
