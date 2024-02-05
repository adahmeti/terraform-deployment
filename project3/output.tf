# output "s3" {
#   value = aws_s3_bucket.dajmox-a.id
# }
output "vpc" {
  value = module.bastion
}