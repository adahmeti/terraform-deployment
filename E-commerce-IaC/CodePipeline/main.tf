####################################################
#Code-Commit
####################################################

resource "aws_codecommit_repository" "ecommercerepos" {

  repository_name = "ecommerceRepos"
  description     = "E-commerce repository for deploying infrastructure"
}

####################################################
#Code-Build
####################################################


resource "aws_codebuild_project" "CBEcommerce" {

  name         = var.codebuild_project_name
  service_role = aws_iam_role.example.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.ca-central-1.amazonaws.com/v1/repos/ecommerceRepos"
    git_clone_depth = 1
 
  #   buildspec       = <<-EOF
  #     version: 0.2
  #     phases:
  #       build:
  #         commands:
  #           - sudo yum update -y
  #           - sudo yum install -y unzip
  #           - curl -fsSL https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip -o terraform.zip
  #           - unzip terraform.zip -d /usr/local/bin/
  #           - terraform version
  #           - terraform init
  #           - terraform plan
  #           - terraform apply --auto-approve
  #       post_build:
  #         commands:
  #         echo: "AWS wait for me Im comming"
  #   EOF
  # }
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "refs/heads/master^{45e75652a6d8ab40869aed3270d6b94124114a4b}"
}
