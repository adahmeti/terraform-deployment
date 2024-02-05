
# resource "aws_rds_cluster" "default" {
#   cluster_identifier      = "aurora-cluster-demo"
#   engine                  = "aurora-mysql"
#   engine_version          = "5.7.mysql_aurora.2.03.2"
#   availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
#   database_name           = "mydb"
#   master_username         = "foo"
#   master_password         = "bar"
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
# }



resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.03.2"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "aurora-cluster-demo"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name      = "mydb"
  master_username    = "denis"
  master_password    = "barbut"
   engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.03.2"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"

}


resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "subnets"
  subnet_ids = [var.priv1A, var.priv2A]
}

# resource "aws_security_group" "rds_sg" {
#   name        = "rds-security-group"
#   description = "Security group for the RDS instance"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }