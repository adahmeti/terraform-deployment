resource "aws_rds_cluster" "cluster_rdstf" {
  engine = "aurora-postgresql"
  engine_version = "15.4"
  cluster_identifier = "database-ecommercee"
  master_username = "akrapoic"
  master_password = "Akrapovic998"
  availability_zones = ["ca-central-1a", "ca-central-1b" ]
  network_type = "IPV4"
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = aws_db_subnet_group.dg-subnet.id
  backup_retention_period = 0
  preferred_backup_window = "05:00-07:00"
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "clusterr_rds" {
  cluster_identifier = "database-ecommercee"
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.cluster_rdstf.engine
  engine_version     = aws_rds_cluster.cluster_rdstf.engine_version
}

resource "aws_db_subnet_group" "dg-subnet" {
  name       = "rds-db-subnet-groupss"
  subnet_ids = [var.priv1A_id, var.priv2A_id]  
}







