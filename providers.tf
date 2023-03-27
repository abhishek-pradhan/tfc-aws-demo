terraform {
  # remote backend: terraform cloud
  backend "remote" {
    ## Required for Terraform Enterprise; Defaults to app.terraform.io for Terraform Cloud
    hostname = "app.terraform.io"
    # This is TFC organization, ensure you set it's value to reflect organization that you created in your Terraform Cloud account
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
# AWS access key credentials are stored as environment variables, to avoid hardcoding here or leaking it on github
provider "aws" {
  region = var.aws_region
}
