terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket = "initialdemobucket"
    key    = "terraform_tfstate/project1.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}