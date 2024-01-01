resource "aws_instance" "example_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "demoec2"  # Replace with your key pair name
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "demoec2"
    Project = "p.1"
  }
}
