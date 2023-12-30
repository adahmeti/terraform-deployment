resource "aws_subnet" "pubKos" {
    vpc_id = aws_vpc.vVPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-north-1a"
    map_public_ip_on_launch = true

    tags ={
        Name = "pubKos"
    }
}

resource "aws_subnet" "privKos"{
    vpc_id = aws_vpc.vVPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-north-1b"
    map_public_ip_on_launch = false

    tags = {
      Name = "privKos"
    }
}
