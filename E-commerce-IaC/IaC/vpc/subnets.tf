resource "aws_subnet" "pub1A" {
  vpc_id                  = aws_vpc.akrapovic-VPC.id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub1A"
  }
}

resource "aws_subnet" "priv1A" {
  vpc_id                  = aws_vpc.akrapovic-VPC.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "priv1A"
  }
}

resource "aws_subnet" "pub2A" {
  vpc_id                  = aws_vpc.akrapovic-VPC.id
  cidr_block              = "10.0.128.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub2A"
  }
}
resource "aws_subnet" "priv2A" {
  vpc_id                  = aws_vpc.akrapovic-VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "priv2A"
  }
}