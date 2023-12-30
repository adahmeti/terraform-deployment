resource "aws_instance" "ec2host"{
    ami = "ami-09ed8fb06b42a771d"
    subnet_id = aws_subnet.pubKos.id
    instance_type = "t3.micro"
    
    security_groups = [aws_security_group.NATOSG.id] 

} 

 resource "aws_key_pair" "klakey"{
    key_name = "klakey"
    public_key = tls_private_key.rsa.public_key_openssh
    }

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "kla-key" {
  content = tls_private_key.rsa.private_key_openssh
  filename = "klakey"
}
