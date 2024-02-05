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
}

module "rds" {
  source = "./rds"

  priv1A    = module.bastion.priv1A_id
  priv2A    = module.bastion.priv2A_id
  rds_sg_id = module.bastion.rds_sg_id
  vpc_id    = module.bastion.vpc_id
}


# module "alb" {
#   source                      = "./alb"
#   loadbalancer_security_group = module.bastion.load-balancer-SG.id
#   pubKos                      = module.bastion.pubKos.id
#   privKos                     = module.bastion.privKos.id
#   vpc_id                      = module.bastion.vpc
#   LT-SG                       = module.bastion.LT-SG.id
#   desired_capacity            = 2
#   max_size                    = 3
#   min_size                    = 1
#   subnet_id                   = module.bastion.pubKos.id
#   image_id                    = "ami-079db87dc4c10ac91"
#   instance_type               = "t2.micro"
# }

# module "rds" {
#   source  = "./rds"
#   pubKos  = module.bastion.pubKos.id
#   privKos = module.bastion.privKos.id
# }
