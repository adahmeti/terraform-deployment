data "aws_iam_policy_document" "aws_iam_policy_document" {

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "attach" {

  role       = aws_iam_role.example.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_role" "example" {

  name               = "${var.codebuild_project_name}-service-role"
  assume_role_policy = data.aws_iam_policy_document.aws_iam_policy_document.json
}

# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "WarningDontCopyPermissionsThatIMadeInsteadDoYourOwnWorkYouLazySouseVisualEditor0",
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:DescribeTargetGroups",
#                 "ec2:DeleteLaunchTemplate",
#                 "elasticloadbalancing:DescribeListeners",
#                 "autoscaling:CreateAutoScalingGroup",
#                 "elasticloadbalancing:DeleteListener",
#                 "elasticloadbalancing:CreateListener",
#                 "elasticloadbalancing:DescribeLoadBalancerAttributes",
#                 "elasticloadbalancing:ModifyLoadBalancerAttributes",
#                 "elasticloadbalancing:CreateLoadBalancer",
#                 "elasticloadbalancing:DescribeTags",
#                 "elasticloadbalancing:DescribeTargetGroupAttributes",
#                 "elasticloadbalancing:ModifyTargetGroupAttributes",
#                 "elasticloadbalancing:AddTags",
#                 "elasticloadbalancing:CreateTargetGroup",
#                 "ec2:DescribeLaunchTemplateVersions",
#                 "ec2:DescribeLaunchTemplates",
#                 "ec2:CreateLaunchTemplate",
#                 "ec2:RevokeSecurityGroupEgress",
#                 "ec2:AuthorizeSecurityGroupEgress",
#                 "ec2:CreateRoute",
#                 "ec2:CreateRouteTable",
#                 "ec2:CreateSecurityGroup",
#                 "ec2:AssociateRouteTable",
#                 "ec2:CreateRouteTable",
#                 "acm:ListCertificates",
#                 "iam:ListServerCertificates",
#                 "cloudfront:ListDistributions",
#                 "iam:CreateAccessKey",
#                 "iam:ListAccessKeys",
#                 "iam:GetLoginProfile",
#                 "codepipeline:ListPipelines",
#                 "codedeploy:ListDeployments",
#                 "codedeploy:ListDeploymentConfigs",
#                 "codedeploy:ListDeployments",
#                 "codebuild:BatchGetProjects",
#                 "codecommit:GetCommitHistory",
#                 "codebuild:ListProjects",
#                 "codecommit:GetObjectIdentifier",
#                 "codecommit:GetRepository",
#                 "codecommit:ListRepositories",
#                 "ec2:DescribeNetworkInterfaces",
#                 "ec2:ModifySubnetAttribute",
#                 "ec2:DescribeSubnets",
#                 "ec2:CreateSubnet",
#                 "ec2:DescribeInternetGateways",
#                 "ec2:AttachInternetGateway",
#                 "ec2:CreateInternetGateway",
#                 "ec2:DescribeVpcAttribute",
#                 "ec2:CreateTags",
#                 "ec2:CreateVpc",
#                 "ec2:DescribeKeyPairs",
#                 "ec2:DescribeVpcs",
#                 "ec2:ImportKeyPair",
#                 "ec2:DescribeAccountAttributes",
#                 "ec2:DescribeRouteTables",
#                 "ec2:DescribeNetworkAcls",
#                 "ec2:DescribeDhcpOptions",
#                 "ec2:DescribeRouteTables",
#                 "ec2:DescribeNatGateways",
#                 "elasticloadbalancing:DescribeLoadBalancers",
#                 "ec2:DescribeSecurityGroups",
#                 "codestar-notifications:ListTargets",
#                 "codestar-notifications:ListNotificationRules",
#                 "ec2:AuthorizeSecurityGroupIngress",
#                 "iam:GetRole",
#                 "iam:PassRole",
#                 "ec2:DescribeLaunchTemplateVersions",
#                 "ec2:CreateLaunchTemplateVersion",
#                 "ec2:CreateLaunchTemplate",
#                 "ec2:ModifyLaunchTemplate",
#                 "ec2:DeleteLaunchTemplate",
#                 "ec2:RunInstances",
#                 "ec2:TerminateInstances",
#                 "ec2:DescribeInstances"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "autoscaling:*",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "cloudwatch:PutMetricAlarm",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:DescribeAccountAttributes",
#                 "ec2:DescribeAvailabilityZones",
#                 "ec2:DescribeImages",
#                 "ec2:DescribeInstanceAttribute",
#                 "ec2:DescribeInstances",
#                 "ec2:DescribeKeyPairs",
#                 "ec2:DescribeLaunchTemplateVersions",
#                 "ec2:DescribePlacementGroups",
#                 "ec2:DescribeSecurityGroups",
#                 "ec2:DescribeSpotInstanceRequests",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeVpcClassicLink"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:DescribeLoadBalancers",
#                 "elasticloadbalancing:DescribeTargetGroups"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "iam:CreateServiceLinkedRole",
#             "Resource": "*",
#             "Condition": {
#                 "StringEquals": {
#                     "iam:AWSServiceName": "autoscaling.amazonaws.com"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:*"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "ForAnyValue:StringLike": {
#                     "ec2:InstanceType": "t2.micro"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:DeleteInternetGateway",
#                 "elasticloadbalancing:DeleteLoadBalancer",
#                 "elasticloadbalancing:DeleteTargetGroup",
#                 "ec2:DeleteKeyPair",
#                 "ec2:DeleteVpc",
#                 "ec2:DeleteSubnet",
#                 "ec2:DeleteRouteTable",
#                 "ec2:DeleteSecurityGroup"
#             ],
#             "Resource": "*"
#         }
#     ]
# }