# output "s3" {
#   value = aws_s3_bucket.dajmox-fr.id
# }
output "vpc" {
  value = module.bastion
}