resource "aws_network_acl" "public_nacls" {
  vpc_id = aws_vpc.akrapovic-VPC.id

  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0  
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
    ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

     ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 23
    to_port    = 23
  }
  egress {
    protocol   = "tcp"
    rule_no    = 900
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0  
  }

  

  tags = {
    Name = "main"
  }
}


resource "aws_network_acl" "private_nacls" {
  vpc_id = aws_vpc.akrapovic-VPC.id


  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }
       
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0  
  }


  tags = {
    Name = "main"
  }
}


resource "aws_network_acl_association" "pub1-nacls" {
  network_acl_id = aws_network_acl.public_nacls.id
  subnet_id      = aws_subnet.pub1A.id
}

resource "aws_network_acl_association" "pub2-nacls" {
  network_acl_id = aws_network_acl.public_nacls.id
  subnet_id      = aws_subnet.pub2A.id
}


resource "aws_network_acl_association" "priv1nacls" {
  network_acl_id = aws_network_acl.private_nacls.id
  subnet_id      = aws_subnet.priv1A.id
}

resource "aws_network_acl_association" "priv2nacls" {
  network_acl_id = aws_network_acl.private_nacls.id
  subnet_id      = aws_subnet.priv2A.id
}