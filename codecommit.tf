resource "aws_codecommit_repository" "test" {
  repository_name = "mydemorepo"
  description     = "This is the Sample App Repository"
}

resource "null_resource" "local_exec_clone" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"] 
    command = <<-EOT
      if (-not (Test-Path .\\${aws_codecommit_repository.test.repository_name})) {
        git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/${aws_codecommit_repository.test.repository_name}
      }
    EOT
    }

  depends_on = [aws_codecommit_repository.test]
  triggers = {
    always_run = "${timestamp()}"
  }
}


resource "null_resource" "local_exec_copy_commit_push" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"] 
    command = <<-EOT
      cd ${aws_codecommit_repository.test.repository_name} ; `
      Copy-Item -Recurse -Force ..\\sourcecode\\* . ; `
      git add . ; `
      git commit -m "Adding all latest files from /sourcecode" ; `
      git push origin master
    EOT
  }

  depends_on = [null_resource.local_exec_clone]

  triggers = {
    always_run = "${timestamp()}"
  }
}

