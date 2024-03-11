module "efs" { 
  source = "./efs" 

  pub1A_id = module.vpc.pub1A_id 
  pub2A_id = module.vpc.pub2A_id
  autoscaling = module.autoscaling-alb.autoscaling_group_name
  efs-sg = module.vpc.efs-sg_id
}

module "DynamoDB" {
  source = "./dynamoDB"
}

module "rds" {
  source = "./rds"

  vpc_id = module.vpc.vpc_id
  priv1A_id = module.vpc.priv1A_id
  priv2A_id = module.vpc.priv2A_id
  rds_sg_id = module.vpc.rds_sg_id
  sns_topic = module.sns.sns_arn
}
module "vpc" {
  source = "./vpc"
}

module "autoscaling-alb" {
  source = "./autoscaling-alb"

  loadbalancer_security_group = module.vpc.ALB-SG
  vpc_id                      = module.vpc.vpc_id
  LT-SG                       = module.vpc.AutoScaling-SG
  subnet1                     = module.vpc.pub1A_id
  subnet2                     = module.vpc.pub2A_id
  aws_sns_topic_arn           = module.sns.sns_arn
}


module "sns" {
  source = "./sns"
}




