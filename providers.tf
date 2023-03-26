terraform {
  # remote backend: terraform cloud
  backend "remote" {
    ## Required for Terraform Enterprise; Defaults to app.terraform.io for Terraform Cloud
    hostname     = "app.terraform.io"
    organization = "tfc-aws-demo-org"

    # use prefix when using multiple workspaces, else use name of single ws
    workspaces {
      prefix = "ws-"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
