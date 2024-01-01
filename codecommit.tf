resource "aws_codecommit_repository" "test" {
  repository_name = "my-demo-repo"
  description     = "This is the Sample App Repository"
}