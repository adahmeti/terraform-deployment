resource "aws_vpc" "vVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vVPC"
  }
}




resource "aws_route_table" "pubKosRT" {
  vpc_id = aws_vpc.vVPC.id
    tags = {
        Name = "pubKosRT"
    }
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kosIGW.id
  }  
}

  resource "aws_route_table" "privKosRT" {
  vpc_id = aws_vpc.vVPC.id
    tags = {
        Name = "privKosRT"
    }
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kosIGW.id
  }  

}
    resource "aws_route_table_association" "public-subnet"{
        route_table_id = aws_route_table.pubKosRT.id
        subnet_id = aws_subnet.pubKos.id
    }

     resource "aws_route_table_association" "private-subnet"{
        route_table_id = aws_route_table.privKosRT.id
        subnet_id = aws_subnet.privKos.id
    }

resource "aws_internet_gateway" "kosIGW" {
    
    vpc_id = aws_vpc.vVPC.id

    tags = {
        Name = "kosIGW"
    }
}

resource "aws_route" "pubRT" {
    route_table_id = aws_route_table.pubKosRT.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kosIGW.id
}



