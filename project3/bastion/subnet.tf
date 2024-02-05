resource "aws_subnet" "pub1A" {
  vpc_id                  = aws_vpc.dajmox-siVPC.id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubKos"
  }
}

resource "aws_subnet" "priv1A" {
  vpc_id                  = aws_vpc.dajmox-siVPC.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "privKos"
  }
}

resource "aws_subnet" "pub2A" {
  vpc_id                  = aws_vpc.dajmox-siVPC.id
  cidr_block              = "10.0.9.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "privKos"
  }
}
resource "aws_subnet" "priv2A" {
  vpc_id                  = aws_vpc.dajmox-siVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "privKos"
  }
}