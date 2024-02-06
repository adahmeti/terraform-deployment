resource "aws_s3_bucket" "nurmanagov" {
  bucket = var.s3-bucket

  tags = {
    Name        = "nurmanagov-bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "nurmanagov" {
  bucket = var.s3-bucket

  versioning_configuration {
    status = "Enabled"
  }
}
# }
# terraform {
#   backend "s3" {
#     bucket = "dajmox-alb"
#     key    = "tfstate/terraform.tfstate"
#     region = "us-east-1"
#   }
# }


resource "aws_key_pair" "abckey" {
  key_name   = "abckey"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "abckey" {
  content  = tls_private_key.rsa.private_key_openssh
  filename = "abckey"
}

