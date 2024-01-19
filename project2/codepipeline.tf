# resource "aws_codepipeline" "codepipeline" {
#   name = "helloworld"
#   role_arn      = aws_iam_role.codepipeline_role.arn
#   pipeline_type = "V1"
#   artifact_store {
#     location = "codepipeline-us-west-1-939231450509"
#     type     = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "Source"
#       category         = "Source"
#       owner            = "AWS"
#       provider         = "CodeCommit"
#       version          = "1"
#       output_artifacts = ["source_output"]

#       configuration = {
#         RepositoryName = "dajmoxRepo"
#         BranchName       = "master"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       input_artifacts  = ["source_output"]
#       output_artifacts = ["build_output"]
#       version          = "1"

#       configuration = {
#         ProjectName = "test-project"
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name            = "Deploy"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "S3"
#       region          = "us-west-1"
#       input_artifacts = ["build_output"]

#       version = "1"
    
#       configuration = {
#         BucketName = aws_s3_bucket.dajmox.id
#         Extract = "true"
#       }
#     }
#   }
# }





# resource "aws_iam_role" "codepipeline_role" {
#   name               = "testrole"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json

#   inline_policy {
#     name = "CodeCommitPolicy"
#     policy = jsonencode({
#       Version = "2012-10-17",
#       Statement = [
#         {
#           Effect = "Allow",
#           Action = "codecommit:GetBranch",
#           Resource = "arn:aws:codecommit:us-west-1:888659321129:dajmoxRepo",
         
#         },
#         {
#            Effect = "Allow",
#           Action = "codecommit:GetCommit",
#           Resource = "arn:aws:codecommit:us-west-1:888659321129:dajmoxRepo",

#         },
#         {
#           Effect = "Allow",
#           Action = "codecommit:UploadArchive",
#           Resource = "arn:aws:codecommit:us-west-1:888659321129:dajmoxRepo",
#         },
#         {
#           Effect = "Allow",
#           Action = [
#             "s3:GetObject",
#             "s3:GetObjectVersion",
#             "s3:GetBucketVersioning",
#             "s3:PutObjectAcl",
#             "s3:PutObject"
#           ],
#           Resource = [
#             "arn:aws:s3:::codepipeline-us-west-1-939231450509/*",
#             "arn:aws:s3:::codepipeline-us-west-1-939231450509"
#           ]
#         },
#         {
#           Effect = "Allow",
#           Action = "codecommit:GetUploadArchiveStatus",
#           Resource = "arn:aws:codecommit:us-west-1:888659321129:dajmoxRepo",
#         },
#          {
#           Effect = "Allow",
#           Action = "codebuild:StartBuild",
#           Resource = "arn:aws:codebuild:us-west-1:888659321129:project/DajmoxZ",
#         },
#         {
#           Effect   = "Allow",
#           Action   = "sts:AssumeRole",
#           Resource = "arn:aws:iam::888659321129:role/testrole",
#           Condition = {
#             StringEquals = {
#               "aws:PrincipalService" : "codepipeline.amazonaws.com"
#             }
#           }
#         },
#       ],
      
#     })
#   }
# }


# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["codepipeline.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

resource "aws_codepipeline" "codepipeline" {
  name     = "dajmoxpipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.dajmox.bucket
    type     = "S3"


  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "dajmoxRepo"
        BranchName       = "master"
      }
    }
  }
 stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "test-project"
      }
    }
  }

 stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      region          = "us-west-1"
      input_artifacts = ["build_output"]

      version = "1"
    
      configuration = {
        BucketName = aws_s3_bucket.dajmox.id
        Extract = "true"
      }
    }
  }
}




# data "aws_iam_policy_document" "asssume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["codepipeline.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

resource "aws_iam_role" "codepipeline_role" {
  name               = "test-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.dajmox.arn,
      "${aws_s3_bucket.dajmox.arn}/*"
    ]
  }


  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:UploadArchive",
      "codecommit:GetUploadArchiveStatus",
    ]


    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}
