resource "aws_codepipeline" "codepipeline" {
  name     = "demo-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = data.aws_s3_bucket.mybucket.id
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
        PollForSourceChanges    = true
        RepositoryName = aws_codecommit_repository.test.id
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
        ProjectName = aws_codebuild_project.example.id
      }
    }
  }
}


#resource "aws_s3_bucket" "codepipeline_bucket" {
#  bucket = "demo-codepipeline-bucket"
#}
#
#resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
#  bucket = aws_s3_bucket.codepipeline_bucket.id
#  acl    = "private"
#}



