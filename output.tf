data "aws_instances" "my_instances" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = ["demonodegroup"]
  }
}

output "App_URL" {
  value = "http://${data.aws_instances.my_instances.public_ips[0]}:30080"
}