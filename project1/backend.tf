terraform {
  required_version = ">=0.11.0"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "tf/terraformstatefile"
    bucket  = "prishitinapeja"

  }
}
