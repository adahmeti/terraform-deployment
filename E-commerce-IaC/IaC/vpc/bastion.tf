resource "aws_instance" "ec2"{
    ami = "ami-09ca61dde3dc883d0"
    subnet_id = aws_subnet.pub1A.id
    instance_type = "t3.micro"
    key_name = "abkey"
    
} 

