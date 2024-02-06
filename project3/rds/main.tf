
resource "aws_iam_role" "dardanians" {
  name = "dardanians"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "export.rds.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "example" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]
    resources = [
      var.s3_bucket_arn,
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "${var.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_policy" "example" {
  name   = "example"
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.dardanians.name
  policy_arn = aws_iam_policy.example.arn
}

resource "aws_kms_key" "example" {
  deletion_window_in_days = 10
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.1"
  availability_zones      = [var.priv1A_az, var.priv2A_az]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "04:00-06:00"
}

resource "aws_db_cluster_snapshot" "example" {
  db_cluster_identifier          = aws_rds_cluster.default.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1234"
}
# aws_db_snapshot.example.db_snapshot_arn
resource "aws_rds_export_task" "example" {
  export_task_identifier = "example"
  source_arn             = aws_db_cluster_snapshot.example.db_cluster_snapshot_arn
  s3_bucket_name         = var.s3_bucket_id
  iam_role_arn           = aws_iam_role.dardanians.arn
  kms_key_id             = aws_kms_key.example.arn

  export_only = ["database"]
  s3_prefix   = "db/file"
}


resource "aws_db_event_subscription" "default" {
  name      = "rds-event-sub"
  sns_topic = var.sns_topic

  source_type = "db-instance"
  source_ids  = [aws_db_instance.default.identifier]

  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}




resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.priv1A_id, var.priv2A_id]

  tags = {
    Name = "My DB subnet group"
  }
}







# #Putting rds in subnets
# resource "aws_db_subnet_group" "database_subnet_group" {
#  name = "database-subnets"
#  subnet_ids = [var.priv1A_id, var.priv2A_id] 
#   tags = {
#     Nmae ="database-subnets"
#   }
# }
# #Creating an rds cluster
# resource "aws_rds_cluster" "dardanians" {
#   cluster_identifier        = "dardanians"
#   availability_zones        = [var.priv1A_az, var.priv2A_az]
#   engine                    = "mysql"
#   db_cluster_instance_class = "db.r6gd.xlarge"
#   storage_type              = "io1"
#   allocated_storage         = 100
#   iops                      = 1000
#   master_username           = "test"
#   master_password           = "admin"
# }

# #Creating a kms key
# resource "aws_kms_key" "a" {
#   description             = "KMS key 1"
#   deletion_window_in_days = 10
# }

# resource "aws_db_cluster_snapshot" "snapshot" {
#   db_cluster_identifier          = aws_rds_cluster.dardanians.id
#   db_cluster_snapshot_identifier = "snapshot-ks"
# }