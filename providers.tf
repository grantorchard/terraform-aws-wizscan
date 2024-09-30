terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = { 
      source = "${path.cwd}"
      project-id = "foobarbaz" 
    }
  }
}