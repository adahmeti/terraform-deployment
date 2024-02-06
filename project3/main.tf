module "sns" {
  source = "./sns"
}
module "bastion" {
  source = "./bastion"
}

module "alb" {
  source = "./alb"

  loadbalancer_security_group = module.bastion.load-balancer-SG.id
  vpc_id                      = module.bastion.vpc_id
  LT-SG                       = module.bastion.LT-SG.id
  region                      = var.region
  subnet1                     = module.bastion.pub1A_id
  subnet2                     = module.bastion.pub2A_id
  aws_sns_topic_arn           = module.sns.sns_arn
}

module "rds" {
  source = "./rds"

  priv1A_id     = module.bastion.priv1A_id
  priv2A_id     = module.bastion.priv2A_id
  rds_sg_id     = module.bastion.rds_sg_id
  vpc_id        = module.bastion.vpc_id
  priv1A_az     = module.bastion.priv1A_az
  priv2A_az     = module.bastion.priv2A_az
  s3_bucket_arn = aws_s3_bucket.nurmanagov.arn
  s3_bucket_id  = aws_s3_bucket.nurmanagov.id
  sns_topic     = module.sns.sns_arn
}


