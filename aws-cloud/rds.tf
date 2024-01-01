data "aws_rds_orderable_db_instance" "sqlserver" {
  engine                     = "MySQL" # CEV engine to be used
  engine_version             = "8.0.31"    # CEV engine version to be used
  storage_type               = "gp3"
  preferred_instance_classes = ["db.m5d.large"]
}


data "aws_kms_key" "by_id" {
  key_id = "505d23e6-e5b8-4d97-9593-e43e3a07c8a7"# KMS key
}

resource "aws_db_instance" "kosova" {
  allocated_storage           = 500
  auto_minor_version_upgrade  = false                               # Custom for SQL Server does not support minor version upgrades
  custom_iam_instance_profile = "AWSRDSCustomSQLServerInstanceRole" 
  db_subnet_group_name        = "subnet-06f24d908a882e4f2" #  subnet group from the RDS Console
  engine                      = data.aws_rds_orderable_db_instance.sqlserver.engine
  engine_version              = data.aws_rds_orderable_db_instance.sqlserver.engine_version
  identifier                  = "babastars"
  instance_class              = data.aws_rds_orderable_db_instance.sqlserver.instance_class
  kms_key_id                  = data.aws_kms_key.by_id.arn
  multi_az                    = false  
  password                    = 12345678
  storage_encrypted           = true
  username                    = "adenis"

}
