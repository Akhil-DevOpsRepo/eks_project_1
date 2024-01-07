resource "aws_codebuild_project" "example" {
  name                   = "demo-codebuild-project"
  description            = "demo CodeBuild Project"
  build_timeout          = 5
  queued_timeout         = 5
  source_version         = "refs/heads/master"
  concurrent_build_limit = 1

  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type      = "S3"
    location  = "initialdemobucket"
    name      = "output.zip"
    packaging = "ZIP"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false

    environment_variable {
      name  = "EKS_CLUSTERNAME"
      value = "eksdemocluster"
    }

    environment_variable {
      name  = "EKS_ROLE_ARN"
      value = "arn:aws:iam::047946443426:role/eks-cluster-role"
    }
    environment_variable {
      name  = "REPOSITORY_URL"
      value = "047946443426.dkr.ecr.us-east-1.amazonaws.com/my-demo-repo"
    }
  }

  source {
    type     = "CODECOMMIT"
    location = "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/mydemorepo"

    git_submodules_config {
      fetch_submodules = false
    }
  }
  cache {
    type = "NO_CACHE"
  }
}

resource "null_resource" "add_codebuild_role_permission" {
  
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"] 
    command = <<-EOT
      aws eks update-cluster-config --region us-east-1 --name "eksdemocluster" --access-config authenticationMode=API_AND_CONFIG_MAP ; `
      Start-Sleep -Seconds 60 ; `
      aws eks create-access-entry --region us-east-1 --cluster-name "eksdemocluster" --principal-arn ${aws_iam_role.codebuild.arn} --type "STANDARD" ; `
      aws eks --region us-east-1 associate-access-policy --cluster-name "eksdemocluster" --principal-arn ${aws_iam_role.codebuild.arn} --access-scope type=cluster --policy-arn "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    EOT
  }
  depends_on = [aws_eks_node_group.example]
}


