data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}
##############################################
#SG for Pub. Subnet
##############################################

resource "aws_security_group" "PubSubnet-SG" {
 
  vpc_id      = aws_vpc.akrapovic-VPC.id
  name        = "PublicSG"
  description = "This security group is used for public subnet"
  
  ingress {
    description = "SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  ingress {
    description = "HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicSG"
  }
}

##############################################
#SG for Priv. Subnet
##############################################

resource "aws_security_group" "PrivSub-SG" {
  name    = "PrivateSub-SG"
  vpc_id  = aws_vpc.akrapovic-VPC.id


ingress  {
    description = "SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress  {
    description = "HTTP"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ALB-Security-Group" {
  name = "ALB-SG"
  vpc_id        = aws_vpc.akrapovic-VPC.id
  
  ingress {
    description = "HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPs"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "AutoScaling-SG" {
  name          = "AutoScaling-SG"
  description = "AS-sg"
  vpc_id        = aws_vpc.akrapovic-VPC.id


  ingress {
    description = "ALL TCP"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "RDS instance security group"
  vpc_id      = aws_vpc.akrapovic-VPC.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "bastion-SG" {
  name = "bastion-host"
  description = "Bastion-host-sg"
  vpc_id = aws_vpc.akrapovic-VPC.id
  

  ingress {  
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
   egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }  
}

resource "aws_security_group" "EFS-sg" {
  name = "EFS"
  description = "efs-sg"
  vpc_id = aws_vpc.akrapovic-VPC.id
  
  ingress {  
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }  
}
