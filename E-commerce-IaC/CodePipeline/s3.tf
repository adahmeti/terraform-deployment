# resource "aws_s3_bucket" "ecommerceadenis" {
#   bucket = "ecommerceadenis"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#     region = "ca-central-1"
#   }
# }


resource "aws_s3_bucket_versioning" "E-commerce" {
  bucket = "ecommerceadenis"

  versioning_configuration {
    status = "Enabled"
  }
}
