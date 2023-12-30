resource "aws_security_group" "NATOSG" {
    vpc_id = aws_vpc.vVPC.id
    name = "NATOSG"
    description = "NATO protection guarantee"
    ingress {
        description = "SSH"
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks =["0.0.0.0/0"]
        
    }
    egress{
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "NATOSG"
    }
}
