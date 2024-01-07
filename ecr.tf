resource "aws_ecr_repository" "my_demo_repo" {
  name                 = "my-demo-repo"
  image_tag_mutability = "IMMUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}