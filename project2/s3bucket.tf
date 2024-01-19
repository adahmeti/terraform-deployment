#For creating a bucket and making it public accesible the code below was used


resource "aws_s3_bucket" "dajmox" {
  bucket = "dajmox"

}


resource "aws_s3_bucket_public_access_block" "dajmox" {
  bucket                  = aws_s3_bucket.dajmox.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
#From the code above the s3 bucket objects can be public
#But to make the S3 bucket publicly accessed for users I used the code below
#The code below is a policy formated in JSON


resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.dajmox.id
  policy = <<EOF
    {
  "Id": "Policy1705761896028",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1705761895151",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::dajmox/*",
      "Principal": "*"
    }
  ]
}
EOF 
}


resource "aws_s3_bucket_website_configuration" "s3_web_hosting" {
  bucket = aws_s3_bucket.dajmox.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

