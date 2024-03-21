resource "aws_s3_bucket" "ecommercepolymathvi" {
  bucket = var.s3-bucket

  tags = {
    Name        = "var.s3-bucket"
    Environment = "Dev"
  }
}