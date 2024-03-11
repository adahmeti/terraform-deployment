resource "aws_rds_cluster" "clusters_rds" {
  engine = "aurora-postgresql"
  engine_version = "15.4"
  cluster_identifier = "database-ecommercee"
  master_username = "akrapoic"
  master_password = "hasanovicbajram"
  availability_zones = ["ca-central-1a", "ca-central-1b" ]
  network_type = "IPV4"
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = aws_db_subnet_group.dg-subnet.id
  backup_retention_period = 0
  preferred_backup_window = "05:00-07:00"
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "cluster_rds" {
  cluster_identifier = "database-ecommercee"
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.clusters_rds.engine
  engine_version     = aws_rds_cluster.clusters_rds.engine_version
}

resource "aws_db_subnet_group" "dg-subnet" {
  name       = "rds-db-subnet-groups"
  subnet_ids = [var.priv1A_id, var.priv2A_id]  
}







