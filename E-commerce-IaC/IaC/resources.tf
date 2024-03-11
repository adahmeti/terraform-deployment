resource "aws_s3_bucket" "ecommercepolymathlabzsz" {
  bucket = var.s3-bucket

  tags = {
    Name        = "ecommercepolymathlabzsz"
    Environment = "Dev"
  }
  
}

resource "aws_key_pair" "abkey" {
  key_name   = "abkey"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "abkey" {
  content  = tls_private_key.rsa.private_key_openssh
  filename = "abkey"
}

