output "vpc_id" {
    value = aws_vpc.dajmox-siVPC.id
    }
output "public-security_group" {
    value = aws_security_group.publicSG
}
output "pub1A_id" {
    value = aws_subnet.pub1A.id
}
output "priv1A_id" {
    value = aws_subnet.priv1A.id
}
output "pub2A_id" {
    value = aws_subnet.pub2A.id
}
output "priv2A_id" {
  value = aws_subnet.priv2A.id
}
output "load-balancer-SG" {
    value = aws_security_group.LBSGSSHHTTP
}
output "LT-SG" {
    value = aws_security_group.LT-SG
}
output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}