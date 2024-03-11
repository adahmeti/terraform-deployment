output "vpc_id" {
    value = aws_vpc.akrapovic-VPC.id
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

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
output "priv1A_az" {
  value = aws_subnet.priv1A.availability_zone
}
output "priv2A_az" {
  value = aws_subnet.priv2A.availability_zone
}
output "pub1A_az" {
  value = aws_subnet.pub1A.availability_zone
}
output "pub2A_az" {
  value = aws_subnet.pub2A.availability_zone
}
output "PrivSub-SG" {
  value = aws_security_group.PrivSub-SG.id
}
output "PubSub-SG" {
  value = aws_security_group.PubSubnet-SG.id
}
output "ALB-SG" {
  value = aws_security_group.ALB-Security-Group.id
}
output "AutoScaling-SG" {
  value = aws_security_group.AutoScaling-SG.id
}
output "efs-sg_id" {
  value = aws_security_group.EFS-sg.id
  
}
output "sg-bastion" {
  value = aws_security_group.bastion-SG
}