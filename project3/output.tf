output "s3" {
  value = aws_s3_bucket.nurmanagov.id
}
output "vpc" {
  value = module.bastion.vpc_id
}
output "subnet_az1" {
  value = module.bastion.priv1A_az
}
output "subnet_az2" {
  value = module.bastion.priv2A_az
}

