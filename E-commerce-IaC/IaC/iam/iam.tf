

# resource "aws_iam_role" "codepipeline_role" {
#   name               = "codepipeline-service-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "codepipeline.amazonaws.com"
#       },
#         "Action": 
#         "s3:GetObject",
#         "s3:GetObjectVersion",
#         "s3:GetBucketVersioning",
#         "s3:PutObjectAcl",
#         "s3:PutObject",
#         "sts:AssumeRole",
#         "ec2:CreateNetworkInterface",
#         "ec2:DescribeDhcpOptions",
#         "ec2:DescribeNetworkInterfaces",
#         "ec2:DeleteNetworkInterface",
#         "ec2:DescribeSubnets",
#         "ec2:DescribeSecurityGroups",
#         "ec2:DescribeVpcs",
#         "s3:GetObject",
#         "s3:GetObjectVersion",
#         "s3:GetBucketVersioning",
#         "s3:PutObjectAcl",
#         "s3:PutObject",
#         "codebuild:BatchGetBuilds",
#         "codebuild:StartBuild",
#         "codecommit:GetBranch",
#         "codecommit:GetCommit",
#         "codecommit:UploadArchive",
#         "codecommit:GetUploadArchiveStatus"
#     }
#   ]
# }
# EOF
# }
# resource "aws_iam_role_policy_attachment" "code-commit" {
#   role       = aws_iam_role.codepipeline_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }