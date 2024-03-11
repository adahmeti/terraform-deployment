##############################################
#   VPC 
##############################################

resource "aws_vpc" "akrapovic-VPC" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "acrapovic-VPC"
  }
}

##############################################
#   Internet Gatewat  
##############################################


resource "aws_internet_gateway" "kosIGW" {

  vpc_id = aws_vpc.akrapovic-VPC.id

  tags = {
    Name = "kosIGW"
  }
}

##############################################
#  Public-Route-Table 
##############################################

resource "aws_route_table" "pubRT1" {
  vpc_id = aws_vpc.akrapovic-VPC.id
  tags = {
    Name = "pubRT1"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kosIGW.id
  }
}

resource "aws_route_table" "pubRT2" {
  vpc_id = aws_vpc.akrapovic-VPC.id
  tags = {
    Name = "pubRT2"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kosIGW.id
  }
}

################################################
#  Private-Route-Table 
################################################

resource "aws_route_table" "privRT1" {
  vpc_id = aws_vpc.akrapovic-VPC.id
  tags = {
    Name = "privRT1"
  }
  route = []
  
}

resource "aws_route_table" "privRT2" {
  vpc_id = aws_vpc.akrapovic-VPC.id
  tags = {
    Name = "privRT2"
  }
  route = []
}

######################################################################
#  Public-Route-Table-association 
######################################################################

resource "aws_route_table_association" "public-subnet1" {
  route_table_id = aws_route_table.pubRT1.id
  subnet_id      = aws_subnet.pub1A.id
}

resource "aws_route_table_association" "public-subnet2" {
  route_table_id = aws_route_table.pubRT2.id
  subnet_id      = aws_subnet.pub2A.id
}


########################################################################
#  Private-Route-Table-association 
########################################################################


resource "aws_route_table_association" "private-subnet1" {
  route_table_id = aws_route_table.privRT1.id
  subnet_id      = aws_subnet.priv1A.id
}

resource "aws_route_table_association" "private-subnet2" {
  route_table_id = aws_route_table.privRT2.id
  subnet_id      = aws_subnet.priv2A.id
}

############################################################################
#Attaching public subnets with Internet Gateway
############################################################################

resource "aws_route" "pubRT" {
  route_table_id         = aws_route_table.pubRT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kosIGW.id
}

resource "aws_route" "pubRT2" {
  route_table_id         = aws_route_table.pubRT2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kosIGW.id
}
